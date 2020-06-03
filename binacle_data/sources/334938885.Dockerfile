#
# Dockerfile for Apache/PHP/MySQL
#
FROM php:apache
MAINTAINER Azure App Service Container Images <appsvc-images@microsoft.com>
# ========
# ENV vars
# ========
#apache httpd
ENV HTTPD_HOME "/etc/apache2"
ENV HTTPD_CONF_DIR "$HTTPD_HOME/sites-enabled"
ENV HTTPD_CONF_FILE "$HTTPD_HOME/sites-enabled/000-default.conf"
ENV HTTPD_LOG_DIR "/home/LogFiles/httpd"
ENV PATH "$HTTPD_HOME/bin":$PATH
# mariadb
ENV MARIADB_DATA_DIR "/home/data/mysql"
ENV MARIADB_LOG_DIR "/home/LogFiles/mysql"
# php
ENV PHP_HOME "/usr/local/etc/php"
ENV PHP_CONF_DIR $PHP_HOME
ENV PHP_CONF_FILE $PHP_CONF_DIR"/php.ini"
ENV PHP_CONF_DIR_SCAN $PHP_CONF_DIR"/conf.d"
ENV PATH "$PHP_HOME/bin":$PATH
#redis
ENV PHPREDIS_VERSION 3.1.2
# supervisor
ENV SUPERVISOR_LOG_DIR "/home/LogFiles/supervisor"
# phpmyadmin
ENV PHPMYADMIN_VERSION "4.8.0"
ENV PHPMYADMIN_DOWNLOAD_URL "https://files.phpmyadmin.net/phpMyAdmin/$PHPMYADMIN_VERSION/phpMyAdmin-$PHPMYADMIN_VERSION-all-languages.tar.gz"
ENV PHPMYADMIN_SHA256 "1e83d60627d8036261af71220eae9ffd8d3150778702720905bcfa85c40ce346"
ENV PHPMYADMIN_SOURCE "/usr/src/phpmyadmin"
ENV PHPMYADMIN_HOME "/home/phpmyadmin"
# ssh
ENV SSH_PASSWD "root:Docker!"
# app
ENV APP_HOME "/home/site/wwwroot"
#
ENV DOCKER_BUILD_HOME "/dockerbuild" 
#   
RUN mkdir -p "$DOCKER_BUILD_HOME"
WORKDIR $DOCKER_BUILD_HOME
RUN set -x \
    && apt-get update \
	&& apt-get install -y -V --no-install-recommends wget curl\    	
	# ----------
	# mariadb
	# ----------
    && apt-get install -y -V --no-install-recommends mariadb-server \	
	# ------
	# php
	# ------
	# mysqli
	&& docker-php-ext-install mysqli && docker-php-ext-enable mysqli \
	# redis
	&& docker-php-source extract \
    && curl -L -o /tmp/redis.tar.gz https://github.com/phpredis/phpredis/archive/$PHPREDIS_VERSION.tar.gz \
	#http://download.redis.io/releases/redis-4.0.10.tar.gz
    && tar xfz /tmp/redis.tar.gz \
    && rm -r /tmp/redis.tar.gz \
    && mv phpredis-$PHPREDIS_VERSION /usr/src/php/ext/redis \
    && docker-php-ext-install redis \
    && docker-php-source delete \
	# xdebug
    && curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
    && chmod +x wp-cli.phar \
    && mv wp-cli.phar /usr/local/bin/wp \
    && apt-get install -y -V --no-install-recommends $PHPIZE_DEPS \
    && pecl install xdebug-beta \
	# && apt-get remove $PHPIZE_DEPS \
	# -------------
	# phpmyadmin
	# -------------
	&& mkdir -p $PHPMYADMIN_SOURCE \
	&& cd $PHPMYADMIN_SOURCE \
	&& wget -O phpmyadmin.tar.gz "$PHPMYADMIN_DOWNLOAD_URL" --no-check-certificate \
	&& echo "$PHPMYADMIN_SHA256 *phpmyadmin.tar.gz" | sha256sum -c - \     	
	# ------
	# ssh
	# ------
    && apt-get install -y -V --no-install-recommends openssh-server \
	&& echo "$SSH_PASSWD" | chpasswd \	
	#---------------
	# supervisor service
	#---------------
    && apt-get install -y -V --no-install-recommends supervisor    
 	# -----------
	# ~. clean up
	# -----------
	# && rm -rf /var/cache/apk/* /tmp/*
# =========
# Configure
# =========
#
# httpd
COPY httpd-main.conf $HTTPD_CONF_DIR/000-default.conf
# php
COPY php.ini $PHP_CONF_DIR/
COPY xdebug.ini $PHP_CONF_DIR_SCAN/
COPY php-opcache.ini $PHP_CONF_DIR_SCAN/
# phpmyadmin
COPY httpd-phpmyadmin.conf $HTTPD_HOME/
COPY phpmyadmin-config.inc.php $PHPMYADMIN_SOURCE/
COPY mariadb.cnf /etc/mysql/
# ssh
COPY sshd_config /etc/ssh/
RUN set -ex \	
	&& test ! -d /var/lib/php/sessions && mkdir -p /var/lib/php/sessions \
	&& chown www-data:www-data /var/lib/php/sessions
	##
#RUN set -ex \
	#&& test ! -d /var/www 
RUN set -ex \
	&& mkdir -p /var/www \
	&& chown -R www-data:www-data /var/www \
	##
	&& rm -rf /var/log/httpd \
	&& ln -s $HTTPD_LOG_DIR /var/log/httpd \
	##
	&& rm -rf /var/log/mysql \
	&& ln -s $MARIADB_LOG_DIR /var/log/mysql \
	##
	&& rm -rf /var/log/supervisor \
	&& ln -s $SUPERVISOR_LOG_DIR /var/log/supervisor \
	##
	&& ln -s $PHPMYADMIN_HOME /var/www/phpmyadmin \
	&& ln -s $APP_HOME /var/www/html \
	##
	&& rm -f /etc/supervisord.conf 	
#
# =====
# final
# =====
COPY supervisord.conf /etc/
COPY entrypoint.sh /usr/local/bin/
RUN chmod u+x /usr/local/bin/entrypoint.sh
EXPOSE 2222 80
ENTRYPOINT ["entrypoint.sh"]



