FROM php:7.1-fpm-alpine

# Install persistent dependencies
RUN apk add --no-cache --virtual .persistent-deps \
    icu-dev \
    libmcrypt-dev

# Install build dependencies
RUN apk add --no-cache --virtual .build-deps \
    autoconf \
    gcc \
    libc-dev \
    libmcrypt-dev \
    make

# Build
RUN set -xe \
    && docker-php-ext-install \
        bcmath \
        intl \
        pdo_mysql \
        mcrypt \
    && pecl install \
        xdebug \
    && docker-php-ext-enable \
        xdebug \
    && apk del .build-deps

COPY etc/php/conf.d/* $PHP_INI_DIR/conf.d/
COPY etc/php/php.ini $PHP_INI_DIR/
COPY etc/php-fpm.d/zz-docker.conf $PHP_INI_DIR/../php-fpm.d/zz-docker.conf

WORKDIR /app
