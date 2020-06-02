#
# Dockerfile for WordPress
#
FROM appsvcorg/wordpress-alpine-php:0.7
MAINTAINER Azure App Service Container Images <appsvc-images@microsoft.com>
# ========
# ENV vars
# ========
# ssh
ENV SSH_PASSWD "root:Docker!"
ENV SSH_PORT 2222
#nginx
ENV NGINX_VERSION 1.14.0
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
ENV PHPREDIS_VERSION 3.1.2
# wordpress
ENV WORDPRESS_SOURCE "/usr/src/wordpress"
ENV WORDPRESS_HOME "/home/site/wwwroot"
#
ENV DOCKER_BUILD_HOME "/dockerbuild"
# ====================
# ====================
# ssh
COPY sshd_config /etc/ssh/ 
# wordpress
COPY wp-config.php $WORDPRESS_SOURCE/
COPY permalink-settings.txt $WORDPRESS_SOURCE/
COPY ssl-settings.txt $WORDPRESS_SOURCE/
# supervisor
COPY supervisord.conf /etc/
# php
COPY php.ini /usr/local/etc/php/php.ini
COPY www.conf /usr/local/etc/php/conf.d/
COPY zz-docker.conf /usr/local/etc/php-fpm.d/zz-docker.conf
# nginx
COPY nginx.conf /etc/nginx/nginx.conf
COPY default.conf /etc/nginx/conf.d/default.conf
COPY phpmyadmin-locations.txt ${PHPMYADMIN_SOURCE}/phpmyadmin-locations.txt
#
COPY entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/entrypoint.sh
EXPOSE 2222 80
ENTRYPOINT ["entrypoint.sh"]
