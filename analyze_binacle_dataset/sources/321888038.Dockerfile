# Based on https://github.com/docker-library/php/blob/35aedb29009b46af6ea1009c9405d01d3f66968e/7.2/alpine3.7/fpm/Dockerfile
FROM php:7.2-fpm-alpine3.7
ARG TIMEZONE

ENV PHP_MEMORY_LIMIT 4000M

# Install required packages
RUN apk add --no-cache --virtual .build-deps git tzdata \
    && git config --global http.sslVerify false

# Configure timezone
RUN cp /usr/share/zoneinfo/${TIMEZONE} /etc/localtime && echo ${TIMEZONE} > /etc/timezone
RUN printf '[PHP]\ndate.timezone = "%s"\n', ${TIMEZONE} >> ${PHP_INI_DIR}/php.ini
RUN printf '[PHP]\nmemory_limit = "%s"\n', ${PHP_MEMORY_LIMIT} > ${PHP_INI_DIR}/php.ini
RUN "date"

RUN apk del .build-deps

WORKDIR /srv/service

RUN docker-php-ext-install pdo pdo_mysql

# Install xdebug
#RUN pecl install xdebug
#RUN docker-php-ext-enable xdebug
#RUN echo "error_reporting = E_ALL" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini
#RUN echo "display_startup_errors = On" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini
#RUN echo "display_errors = On" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini
#RUN echo "xdebug.remote_enable=1" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini
#RUN echo "xdebug.remote_connect_back=1" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini
#RUN echo "xdebug.idekey=\"PHPSTORM\"" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini
#RUN echo "xdebug.remote_port=9001" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini

#COPY app/ ${PROJECT_DIR}/app/

#RUN chown -R nobody.nobody /srv/service

#USER nobody
