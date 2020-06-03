FROM appsvcorg/drupal-nginx-fpm:0.6
LABEL maintainer ="Azure App Service Container Images <appsvc-images@microsoft.com>"
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
# drupal
ENV DRUPAL_SOURCE "/usr/src/drupal"
#nginx
ENV NGINX_LOG_DIR "/home/LogFiles/nginx"
#varnish
ENV VARNISH_LOG_DIR "/home/LogFiles/varnish"
#php
ENV PHP_CONF_FILE "/usr/local/etc/php/php.ini"
# ====================
# Download and Install
# ~. essentials
# 1. Drupal
# ====================
RUN set -ex \
# --------
# ~. essentials
# --------
# ~. PHP extensions
# --------
# -------------
# 1. Drupal
# -------------
# ----------
# 2. composer
# ----------
# ----------
# 3. drush
# ----------
# ----------
# 4. varnish
# ----------
# ----------
# 4. Java
# ----------
	&& apk update \ 
	&& apk add bash openjdk8-jre \
# ----------
# ~. clean up
# ----------
	&& apk upgrade \
	&& rm -rf /var/cache/apk/* \
	&& rm -rf /etc/nginx/conf.d/default.conf 
# =========
# Configure
# =========
WORKDIR $DRUPAL_HOME
# Apache Solr
COPY apache-solr-3.5.0-src.tgz /usr/src/apache-solr.tgz
# =====
# final
# =====
COPY entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/entrypoint.sh
EXPOSE 2222 80
ENTRYPOINT ["entrypoint.sh"]
