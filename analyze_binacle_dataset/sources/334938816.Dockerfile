#
# Dockerfile for Apache/PHP/MySQL
#
FROM alpine:3.6
MAINTAINER Azure App Service Container Images <appsvc-images@microsoft.com>

# ========
# ENV vars
# ========
#apache httpd
ENV HTTPD_VERSION "2.4.29"
ENV HTTPD_DOWNLOAD_URL "http://archive.apache.org/dist/httpd/httpd-"$HTTPD_VERSION".tar.gz"
ENV HTTPD_SHA256 "948e4a11278a5954698b880b30f401b1e9ab743713ee2c7280a54dd4ddd87085"
ENV HTTPD_SOURCE "/usr/src/httpd"
ENV HTTPD_HOME "/usr/local/httpd"
ENV HTTPD_CONF_DIR "$HTTPD_HOME/conf"
ENV HTTPD_CONF_FILE "$HTTPD_CONF_DIR/httpd.conf"
ENV HTTPD_LOG_DIR "/home/LogFiles/httpd"
ENV PATH "$HTTPD_HOME/bin":$PATH
# mariadb
ENV MARIADB_DATA_DIR "/home/data/mysql"
ENV MARIADB_LOG_DIR "/home/LogFiles/mysql"
# php
ENV PHP_VERSION "7.1.10"
ENV PHP_DOWNLOAD_URL "https://secure.php.net/get/php-"$PHP_VERSION.tar.gz"/from/this/mirror"
ENV PHP_SHA256 "edc6a7c3fe89419525ce51969c5f48610e53613235bbef255c3a4db33b458083"
ENV PHP_SOURCE "/usr/src/php"
ENV PHP_HOME "/usr/local/php"
ENV PHP_CONF_DIR $PHP_HOME"/etc"
ENV PHP_CONF_FILE $PHP_CONF_DIR"/php.ini"
ENV PHP_CONF_DIR_SCAN $PHP_CONF_DIR"/conf.d"
ENV PATH "$PHP_HOME/bin":$PATH
# phpmyadmin
ENV PHPMYADMIN_VERSION "4.7.5"
ENV PHPMYADMIN_DOWNLOAD_URL "https://files.phpmyadmin.net/phpMyAdmin/$PHPMYADMIN_VERSION/phpMyAdmin-$PHPMYADMIN_VERSION-all-languages.tar.gz"
ENV PHPMYADMIN_SHA256 "c62b4072b9dc2a858f51ddd95e731c4717eb2fba85e1e108564736b8c8de1a2b"
ENV PHPMYADMIN_SOURCE "/usr/src/phpmyadmin"
ENV PHPMYADMIN_HOME "/home/phpmyadmin"
# ssh
ENV SSH_PASSWD "root:Docker!"
# app
ENV APP_HOME "/home/site/wwwroot"
ENV PHPIZE_DEPS "\
		autoconf \
		dpkg-dev dpkg \
		file \
		g++ \
		gcc \
		libc-dev \
		make \
		pcre-dev \
		pkgconf \
        re2c"
#
ENV DOCKER_BUILD_HOME "/dockerbuild"
    # ---------------
	# 2. apache httpd
	# ---------------
RUN mkdir -p "$DOCKER_BUILD_HOME"
WORKDIR $DOCKER_BUILD_HOME
RUN set -x \
    # ensure www-data user exists
	&& addgroup -g 82 -S www-data \
	&& adduser -u 82 -D -S -G www-data www-data
# 82 is the standard uid/gid for "www-data" in Alpine
# http://git.alpinelinux.org/cgit/aports/tree/main/apache2/apache2.pre-install?h=v3.3.2
# http://git.alpinelinux.org/cgit/aports/tree/main/lighttpd/lighttpd.pre-install?h=v3.3.2
# http://git.alpinelinux.org/cgit/aports/tree/main/nginx-initscripts/nginx-initscripts.pre-install?h=v3.3.2

RUN mkdir -p "$HTTPD_HOME" \
	&& chown www-data:www-data "$HTTPD_HOME" \
    && mkdir -p "$HTTPD_SOURCE" \
	&& runDeps=' \
		apr-dev \
		apr-util-dev \
		apr-util-ldap \
		perl \
	' \
	&& apk add --no-cache --virtual .build-deps \
		$runDeps \
		ca-certificates \
		coreutils \
		dpkg-dev dpkg \
		gcc \
		gnupg \
		libc-dev \
		# mod_session_crypto
		libressl \
		libressl-dev \
		# mod_proxy_html mod_xml2enc
		libxml2-dev \
		# mod_lua
                lua-dev \
  		make \
		# mod_http2
		nghttp2-dev \
                pcre-dev \
		tar \
		# mod_deflate
                zlib-dev \
	&& cd $DOCKER_BUILD_HOME \
	&& wget -O httpd.tar.gz $HTTPD_DOWNLOAD_URL --no-check-certificate \
	&& echo "$HTTPD_SHA256 *httpd.tar.gz" | sha256sum -c - \
	&& tar -xf httpd.tar.gz -C $HTTPD_SOURCE --strip-components=1 \
	&& cd "$HTTPD_SOURCE" \
	&& ./configure \
		--prefix=$HTTPD_HOME \
		### using prefork for PHP. see http://php.net/manual/en/install.unix.apache2.php
		--with-mpm=prefork \
		--enable-mods-shared=reallyall \
		--enable-ssl \
                --enable-so \
		--enable-deflate \
        # https://httpd.apache.org/docs/2.2/programs/configure.html
	&& make -j "$(nproc)" \
	&& make install \
	&& make clean \
	## clean up
	&& rm -rf $HTTPD_SOURCE \
		$HTTPD_HOME/man \
		$HTTPD_HOME/manual \
	&& rm $DOCKER_BUILD_HOME/httpd.tar.gz \
	&& runDeps="$runDeps $( \
		scanelf --needed --nobanner --format '%n#p' --recursive /usr/local \
			| tr ',' '\n' \
			| sort -u \
			| awk 'system("[ -e /usr/local/lib/" $1 " ]") == 0 { next } { print "so:" $1 }' \
	)" \
	&& apk add --virtual .httpd-rundeps $runDeps \
	&& apk del .build-deps \
	
	# ----------
	# 3. mariadb
	# ----------
        && apk add --update mariadb mariadb-client \
	
	# ------
	# 4. php
	# ------
	### see http://php.net/manual/en/install.unix.apache2.php
	### see http://linuxfromscratch.org/blfs/view/svn/general/php.html
	&& mkdir -p $PHP_SOURCE \
	&& mkdir -p $PHP_HOME \
	&& apk add --no-cache --virtual .persistent-deps \
		ca-certificates \
		curl \
		tar \
		xz \
		# https://github.com/docker-library/php/issues/494
                libressl \ 
	&& mkdir -p $PHP_CONF_DIR_SCAN \
	&& cd $DOCKER_BUILD_HOME \
	&& wget -O php.tar.gz "$PHP_DOWNLOAD_URL" --no-check-certificate \
	&& echo "$PHP_SHA256 *php.tar.gz" | sha256sum -c - \
	&& tar -xf php.tar.gz -C $PHP_SOURCE --strip-components=1 \	
	## configure, make, install
	&& apk add --no-cache --virtual .build-deps \
		$PHPIZE_DEPS \
		coreutils \
		curl-dev \
		libedit-dev \
		libressl-dev \
		libxml2-dev \
		sqlite-dev \
		bzip2-dev \
		libjpeg-turbo-dev \
		libpng-dev \
		gmp-dev \
                icu-dev \
                openldap-dev \
                libmcrypt-dev \	
		libxslt-dev \
                apr-dev \
                apr-util-dev \
                apr-util-ldap \
	&& cd $PHP_SOURCE \
	&& ./configure \
		--prefix=$PHP_HOME \
		### we don't need CGI version of PHP here
		--disable-cgi \
		--enable-bcmath \
		--enable-intl \
		--enable-ftp \
		--enable-mbstring \
		--enable-soap \
		--enable-zip \
		--with-apxs2=$HTTPD_HOME/bin/apxs \
		--with-bz2 \
		--with-config-file-path=$PHP_CONF_DIR \
		--with-config-file-scan-dir=$PHP_CONF_DIR_SCAN \
		--with-curl \
		--with-gd \
		--with-jpeg-dir \
		--with-png-dir \
		--with-gmp \
		--with-ldap \
		--with-mcrypt \
		--with-mhash \
		### for phpmyadmin
		--with-mysqli=mysqlnd \
		--with-mysql=mysqlnd \
		--with-libedit \
        --with-pcre-regex=/usr \ 
		--with-openssl \
		### see http://php.net/manual/en/mysqlinfo.library.choosing.php
		--with-pdo-mysql=mysqlnd \
		--with-xsl \
		--with-zlib \
	&& make -j "$(nproc)" \
	&& make install \
	&& make clean \
	## clean up
	&& rm -rf $PHP_SOURCE \
	&& rm -rf $PHP_HOME/php/man \
	&& rm $DOCKER_BUILD_HOME/php.tar.gz \
	&& runDeps="$( \
		scanelf --needed --nobanner --format '%n#p' --recursive /usr/local \
			| tr ',' '\n' \
			| sort -u \
			| awk 'system("[ -e /usr/local/lib/" $1 " ]") == 0 { next } { print "so:" $1 }' \
	)" \
	&& apk add --no-cache --virtual .php-rundeps $runDeps \
	&& apk del .build-deps \
	# https://github.com/docker-library/php/issues/443
	&& pecl update-channels \
        && rm -rf /tmp/pear ~/.pearrc \
    
	# -------------
	# 5. phpmyadmin
	# -------------
	&& mkdir -p $PHPMYADMIN_SOURCE \
	&& cd $PHPMYADMIN_SOURCE \
	&& wget -O phpmyadmin.tar.gz "$PHPMYADMIN_DOWNLOAD_URL" --no-check-certificate \
	&& echo "$PHPMYADMIN_SHA256 *phpmyadmin.tar.gz" | sha256sum -c - \
	
	# ------
	# 6. ssh
	# ------
        && apk add --update openssh-server \
	&& echo "$SSH_PASSWD" | chpasswd \
	
	#---------------
	# openrc service
	#---------------
        && apk update && apk add openrc \         
    # can't do cgroups
    && sed -i 's/"cgroup_add_service/" # cgroup_add_service/g' /lib/rc/sh/openrc-run.sh \

 	# -----------
	# ~. clean up
	# -----------
	&& rm -rf /var/cache/apk/* /tmp/* 	

# =========
# Configure
# =========

# httpd
COPY httpd.conf $HTTPD_CONF_DIR/
COPY httpd-modules.conf $HTTPD_CONF_DIR/
COPY httpd-php.conf $HTTPD_CONF_DIR/
# php
COPY php.ini $PHP_CONF_DIR/
COPY php-opcache.ini $PHP_CONF_DIR_SCAN/
# phpmyadmin
COPY httpd-phpmyadmin.conf $HTTPD_CONF_DIR/
COPY phpmyadmin-config.inc.php $PHPMYADMIN_SOURCE/
COPY mariadb.cnf /etc/mysql/
# ssh
COPY sshd_config /etc/ssh/
RUN set -ex \
	&& echo 'Include conf/httpd-php.conf' >> $HTTPD_CONF_FILE \
	&& test ! -d /var/lib/php/sessions && mkdir -p /var/lib/php/sessions \
	&& chown www-data:www-data /var/lib/php/sessions \
	##
	&& test ! -d /var/www && mkdir -p /var/www \
	&& chown -R www-data:www-data /var/www \
	##
	&& rm -rf /var/log/httpd \
	&& ln -s $HTTPD_LOG_DIR /var/log/httpd \
	##
	&& rm -rf /var/log/mysql \
	&& ln -s $MARIADB_LOG_DIR /var/log/mysql \
	##
	&& ln -s $PHPMYADMIN_HOME /var/www/phpmyadmin \
	&& ln -s $APP_HOME /var/www/wwwroot 

# =====
# final
# =====
COPY entrypoint.sh /usr/local/bin/
RUN chmod u+x /usr/local/bin/entrypoint.sh
EXPOSE 2222 80
ENTRYPOINT ["entrypoint.sh"]



