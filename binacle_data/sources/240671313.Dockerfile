# akhomy/alpine-php-fpm
ARG BASE_IMAGE_TAG=latest
FROM akhomy/alpine-base:${BASE_IMAGE_TAG}
ARG IMAGE_EXTENSIONS=core
ENV IMAGE_EXTENSIONS=${IMAGE_EXTENSIONS}
LABEL maintainer=andriy.khomych@gmail.com
### Updates packages list.
RUN apk --no-cache update
### Install user.
RUN set -e && \
    addgroup -g 1000 -S www-data && \
    adduser -u 1000 -D -S -s /bin/bash -G www-data www-data && \
    sed -i '/^www-data/s/!/*/' /etc/shadow
### Creates scripts dirs.
# Creates /temp_dir for using.
RUN mkdir /temp_docker && chmod -R +x /temp_docker && cd /temp_docker
RUN mkdir /temp_docker/extensions && chmod -R +x /temp_docker/extensions
### Initialize.
COPY tools/ /tools/
RUN /bin/ash /tools/install-build-tools.sh
### Copies extensions.
COPY extensions/ /temp_docker/extensions
### Copies configs.
COPY configs/ /temp_docker/php-fpm/configs
# Installs extensions.
ARG DRUSH_VERSION=8.x
ARG XDEBUG_VERSION=2.7.0
RUN /bin/sh /tools/installer.sh ${IMAGE_EXTENSIONS} /temp_docker/extensions /temp_docker/extensions/
### Cron.
COPY crontasks.txt /home
# Cleans.
RUN /bin/sh /tools/clean.sh
# Uninstall build tools.
RUN /bin/sh /tools/uninstall-build-tools.sh
# Create /temp_configs_dir for using
RUN mkdir /temp_configs_dir && chmod -R +x /temp_configs_dir && cd /temp_configs_dir
# Entrypoint.
COPY docker-entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/docker-entrypoint.sh && mkdir -p /var/www/localhost/htdocs && \
chown -R www-data:www-data /var/www/ && \
chown -R www-data:www-data /var/log/
WORKDIR /var/www/localhost/htdocs
ADD docker-entrypoint.sh docker-entrypoint.sh
ENTRYPOINT ["docker-entrypoint.sh"]
