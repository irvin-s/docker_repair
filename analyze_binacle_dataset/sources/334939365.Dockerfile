
FROM appsvcorg/nginx-fpm:php7.3.4
MAINTAINER Azure App Service Container Images <appsvc-images@microsoft.com>
# ========
# ENV vars
# ========
# ssh
ENV SSH_PASSWD "root:Docker!"
ENV SSH_PORT 2222
ENV NGINX_LOG_DIR "/home/LogFiles/nginx"
#php
ENV PHP_HOME "/usr/local/etc/php"
ENV PHP_CONF_DIR $PHP_HOME
ENV PHP_CONF_FILE $PHP_CONF_DIR"/php.ini"
# mariadb
ENV MARIADB_DATA_DIR "/home/data/mysql"
ENV MARIADB_LOG_DIR "/home/LogFiles/mysql"
# phpmyadmin
ENV PHPMYADMIN_SOURCE "/usr/src/phpmyadmin"
ENV PHPMYADMIN_HOME "/home/phpmyadmin"
# redis
ENV PHPREDIS_VERSION 4.2.0
#Web Site Home
ENV HOME_SITE "/home/site/wwwroot"
# supervisor
ENV SUPERVISOR_LOG_DIR "/home/LogFiles/supervisor"
#
# ====================
# Download and Install
# ~. tools
# 1. redis
# ====================
RUN set -ex \
    # --------
	# ~. tools
	# --------
    && apk update \
    && apk add --no-cache redis \
	# --------
	# 1. PHP extensions
	# -------- 
	# install the PHP extensions we need
	&& docker-php-source extract \
    && curl -L -o /tmp/redis.tar.gz https://github.com/phpredis/phpredis/archive/$PHPREDIS_VERSION.tar.gz \
    && tar xfz /tmp/redis.tar.gz \
    && rm -r /tmp/redis.tar.gz \
    && mv phpredis-$PHPREDIS_VERSION /usr/src/php/ext/redis	\
	&& apk add --no-cache --virtual .build-deps \
		libjpeg-turbo-dev \
		libpng-dev \
                libzip-dev \	
	&& docker-php-ext-configure gd --with-png-dir=/usr --with-jpeg-dir=/usr \
	&& docker-php-ext-install gd zip redis \
	&& runDeps="$( \
		scanelf --needed --nobanner --format '%n#p' --recursive /usr/local/lib/php/extensions \
			| tr ',' '\n' \
			| sort -u \
			| awk 'system("[ -e /usr/local/lib/" $1 " ]") == 0 { next } { print "so:" $1 }' \
	)" \
	&& apk add --virtual .wordpress-phpexts-rundeps $runDeps \
	&& apk del .build-deps \
	&& docker-php-source delete \
	# ----------
	# ~. upgrade/clean up
	# ----------
	&& apk upgrade \
	&& rm -rf /var/cache/apk/* \
	&& rm -rf /tmp/*
# =====
# final
# =====
COPY entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/entrypoint.sh
EXPOSE 2222 80
ENTRYPOINT ["entrypoint.sh"]
