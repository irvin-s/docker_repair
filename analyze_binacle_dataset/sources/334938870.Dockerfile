#
# Dockerfile for Apache/PHP/MySQL
#
FROM alpine:3.8
MAINTAINER Azure App Service Container Images <appsvc-images@microsoft.com>
# ========
# ENV vars
# ========
#apache httpd
ENV HTTPD_HOME "/etc/apache2"
ENV HTTPD_CONF_DIR "$HTTPD_HOME/conf.d"
ENV HTTPD_CONF_FILE "$HTTPD_HOME/httpd.conf"
ENV HTTPD_LOG_DIR "/home/LogFiles/httpd"
ENV HTTPD_PID_DIR "/run/apache2"
ENV PATH $HTTPD_HOME/bin:$PATH
# mariadb
ENV MARIADB_DATA_DIR "/home/data/mysql"
ENV MARIADB_LOG_DIR "/home/LogFiles/mysql"
# php
ENV PHP_HOME "/etc/php7"
ENV PHP_CONF_DIR $PHP_HOME
ENV PHP_CONF_FILE $PHP_CONF_DIR"/php.ini"
ENV PHP_CONF_DIR_SCAN $PHP_CONF_DIR"/conf.d"
ENV PATH $PHP_HOME/bin:$PATH
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
# ensure www-data user exists
RUN set -x \
	&& addgroup -g 82 -S www-data \
	&& adduser -u 82 -D -S -G www-data www-data
	# ---------------
	# 2. apache httpd
	# ---------------
RUN mkdir -p "$DOCKER_BUILD_HOME"
WORKDIR $DOCKER_BUILD_HOME
RUN set -x \
    && apk update \
    && apk add apache2 apache2-ssl \
	# ----------
	# 3. mariadb
	# ----------
    && apk add --update mariadb mariadb-client \	
	# ------
	# 4. php
	# ------
	&& apk add php7-common php7-iconv php7-json php7-gd php7-curl php7-xml php7-simplexml php7-pgsql php7-imap php7-cgi fcgi \
	&& apk add php7-pdo php7-pdo_pgsql php7-soap php7-xmlrpc php7-posix php7-mcrypt php7-gettext php7-ldap php7-ctype php7-dom \
	&& apk add php7-apache2 php7-embed php7-session php7-mbstring\
	&& apk add php7-mysqli php7-opcache php7-xdebug \
	#php5-zlib \	
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
	#---------------
	# supervisor service
	#---------------
    && apk update && apk add supervisor \   
 	# -----------
	# ~. clean up
	# -----------
	&& rm -rf /var/cache/apk/* /tmp/*
# =========
# Configure
# =========
#
# httpd
COPY httpd.conf $HTTPD_HOME/
COPY httpd-modules.conf $HTTPD_CONF_DIR/
COPY httpd-php.conf $HTTPD_CONF_DIR/
# php
COPY php.ini $PHP_CONF_DIR/
COPY xdebug.ini $PHP_CONF_DIR_SCAN/
COPY php-opcache.ini $PHP_CONF_DIR_SCAN/
# phpmyadmin
COPY httpd-phpmyadmin.conf $HTTPD_CONF_DIR/
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
	&& ln -s $APP_HOME /var/www/wwwroot \
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



