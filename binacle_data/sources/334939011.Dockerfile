FROM appsvcorg/nginx-fpm:php7.2.11
MAINTAINER Azure App Service Container Images <appsvc-images@microsoft.com>
# ========
# ENV vars
# ========
#
ENV DOCKER_BUILD_HOME "/dockerbuild"
# drupal 
ENV DRUPAL_HOME "/home/site/wwwroot"
# mariadb
ENV MARIADB_DATA_DIR "/home/data/mysql"
ENV MARIADB_LOG_DIR "/home/LogFiles/mysql"
# phpmyadmin
ENV PHPMYADMIN_SOURCE "/usr/src/phpmyadmin"
ENV PHPMYADMIN_HOME "/home/phpmyadmin"
#nginx
ENV NGINX_LOG_DIR "/home/LogFiles/nginx"
#php
ENV PHP_HOME "/usr/local/etc/php"
ENV PHP_CONF_DIR $PHP_HOME
ENV PHP_CONF_FILE $PHP_CONF_DIR"/php.ini"
# Composer
# Updation: https://getcomposer.org/download/
ENV COMPOSER_DOWNLOAD_URL "https://getcomposer.org/installer"
ENV COMPOSER_ALLOW_SUPERUSER 1
ENV COMPOSER_HOME /home/.composer
ENV COMPOSER_VERSION "1.6.1"
# SHA384SUM https://composer.github.io/installer.sha384sum
ENV COMPOSER_SETUP_SHA 544e09ee996cdf60ece3804abc52599c22b1f40f4323403c44d44fdfdd586475ca9813a858088ffbc1f233e9b180f061
# ====================
# Download and Install
# ~. essentials
# 1. Drupal
# ====================
RUN mkdir -p $DOCKER_BUILD_HOME
WORKDIR $DOCKER_BUILD_HOME
# --------
# ~. essentials
# --------
RUN set -ex \
    && apk update \
    && apk add --no-cache \
# --------
# ~. PHP extensions
# --------
# install the PHP extensions we need
# postgresql-dev is needed for https://bugs.alpinelinux.org/issues/3642
    && docker-php-source extract \
    && apk add --no-cache                  \
            --virtual .build-dependencies   \
                $PHPIZE_DEPS                \
                zlib-dev                    \
                cyrus-sasl-dev              \
                git                         \
                autoconf                    \
                g++                         \
                libtool                     \
                make                        \
                pcre-dev                    \    
            tini                            \
            libintl                         \
            icu                             \
            icu-dev                         \
            libxml2-dev                     \
            postgresql-dev                  \
            freetype-dev                    \
            libjpeg-turbo-dev               \
            libpng-dev                      \
            gmp                             \
            gmp-dev                         \
            libmemcached-dev                \
            imagemagick-dev                 \
            libssh2                         \
            libssh2-dev                     \
            libxslt-dev                     \		                  
	&& docker-php-ext-configure gd \
		--with-freetype-dir=/usr/include/ \
		--with-jpeg-dir=/usr/include/ \
		--with-png-dir=/usr/include/ \
	&& docker-php-ext-install -j "$(nproc)" \
		gd \
		opcache \
		pdo_mysql \
		pdo_pgsql \
		zip \		
	&& pecl install apcu \
	&& docker-php-ext-enable apcu \
	&& runDeps="$( \
		scanelf --needed --nobanner --format '%n#p' --recursive /usr/local \
			| tr ',' '\n' \
			| sort -u \
			| awk 'system("[ -e /usr/local/lib/" $1 " ]") == 0 { next } { print "so:" $1 }' \
	)" \
	&& apk add --virtual .drupal-phpexts-rundeps $runDeps \
	&& apk del .build-dependencies \	
	&& docker-php-source delete \
# -------------
# 1. Drupal
# -------------
# Install by Git
# ----------
# 2. composer
# ----------
RUN set -ex \
	&& curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/bin --filename=composer \
	&& composer self-update \
# ----------
# 3. drush
# ----------
    && rm -rf /home/.composer && export COMPOSER_HOME='/root/.composer/' \
    && composer global require consolidation/cgr \
	&& composer_home=$(find / -name .composer) \
    && ln -s $composer_home/vendor/bin/cgr /usr/local/bin/cgr \
	&& cgr drush/drush \
    && ln -s $composer_home/vendor/bin/drush /usr/local/bin/drush \
# ----------
# ~. clean up
# ----------
	&& apk update \
	&& apk upgrade \
	&& rm -rf /var/cache/apk/* 
# =========
# Configure
# =========
WORKDIR $DRUPAL_HOME
RUN rm -rf $DOCKER_BUILD_HOME
# nginx
COPY nginx.conf /etc/nginx/nginx.conf
COPY default.conf /etc/nginx/conf.d/default.conf
# php
COPY php.ini /usr/local/etc/php/php.ini
COPY opcache-recommended.ini /usr/local/etc/php/conf.d/opcache-recommended.ini
COPY www.conf /usr/local/etc/php/conf.d/www.conf
COPY zz-docker.conf /usr/local/etc/php-fpm.d/zz-docker.conf
# phpmyadmin
COPY phpmyadmin-default.conf $PHPMYADMIN_SOURCE/phpmyadmin-default.conf
# =====
# final
# =====
COPY entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/entrypoint.sh
EXPOSE 2222 80
ENTRYPOINT ["entrypoint.sh"]
