FROM appsvcorg/drupal-nginx-fpm:0.44
MAINTAINER Azure App Service Container Images <appsvc-images@microsoft.com>
# ========
# ENV vars
# ========
#
ENV DOCKER_BUILD_HOME "/dockerbuild"
# drupal 
ENV DRUPAL_HOME "/home/site/wwwroot"
ENV DRUPAL_PRJ "/home/drupal_prj"
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
    && apk add --no-cache varnish\
# -------------
# 1. Drupal
# -------------
# Will be pulled by Git
# ----------
# ~. clean up
# ----------
	&& apk upgrade \
	&& rm -rf /var/cache/apk/* 
# =========
# Configure
# =========
WORKDIR $DRUPAL_HOME
RUN rm -rf $DOCKER_BUILD_HOME
# nginx
COPY spec-settings.conf /etc/nginx/conf.d/spec-settings.conf
COPY nginx.conf /etc/nginx/nginx.conf
RUN rm -rf /etc/nginx/conf.d/default.conf
# php
COPY opcache-recommended.ini /usr/local/etc/php/conf.d/opcache-recommended.ini
# phpmyadmin
COPY phpmyadmin-default.conf $PHPMYADMIN_SOURCE/phpmyadmin-default.conf
COPY phpmyadmin-config.inc.php $PHPMYADMIN_SOURCE/phpmyadmin-config.inc.php
COPY default.phpmyadmin.vcl $PHPMYADMIN_SOURCE/default.phpmyadmin.vcl
# Varinish
COPY default.vcl /etc/varnish/default.vcl
# =====
# final
# =====
COPY entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/entrypoint.sh
EXPOSE 2222 80
ENTRYPOINT ["entrypoint.sh"]
