#
# Dockerfile for moodle
#
FROM appsvcorg/moodle-nginx-fpm:0.21
LABEL maintainer ="Azure App Service Container Images <appsvc-images@microsoft.com>"
# ========
# ENV vars
# ========
# ssh
ENV SSH_PASSWD "root:Docker!"
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
# moodle
ENV MOODLE_HOME "/home/site/wwwroot"
ENV MOODLE_SOURCE "/usr/src/moodle"
# redis
ENV PHPREDIS_VERSION 3.1.2
# memcached
ENV MEMCACHED_VERSION 1.5.12
ENV MEMCACHED_SHA1 f67096ba64b0c47668bcad5b680010c4f8987d4c
#
ENV DOCKER_BUILD_HOME "/dockerbuild"
# =========
# Configure
# =========
COPY config.php $MOODLE_SOURCE/
# nginx
COPY default.conf /etc/nginx/conf.d/
# phpmyadmin
COPY phpmyadmin-default.conf $PHPMYADMIN_SOURCE/
# =====
# final
# =====
# supervisor
COPY supervisord.conf /etc/
#
COPY entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/entrypoint.sh
EXPOSE 2222 80
ENTRYPOINT ["entrypoint.sh"]
