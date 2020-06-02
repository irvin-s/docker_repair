FROM composer:1.8 AS composer
FROM php:7.3-fpm-alpine

COPY --from=composer /usr/bin/composer /usr/bin/composer
COPY php.ini /usr/local/etc/php/conf.d/php.ini

ENV COMPOSER_ALLOW_SUPERUSER 1
ENV COMPOSER_HOME /tmp

RUN set -ex && \
    NPROC=$(grep -c ^processor /proc/cpuinfo 2>/dev/null || 1) && \
    apk --no-cache add \
        autoconf \
        build-base \
        bzip2-dev \
        git \
        icu \
        icu-dev \
        freetype \
        freetype-dev \
        libjpeg-turbo \
        libjpeg-turbo-dev \
        libpng \
        libpng-dev \
        libwebp \
        libwebp-dev \
        libzip \
        libzip-dev \
        postgresql-dev \
        postgresql-libs \
        rabbitmq-c \
	rabbitmq-c-dev && \
    docker-php-ext-configure gd \
        --with-gd \
        --with-freetype-dir=/usr/include/ \
        --with-png-dir=/usr/include/ \
        --with-jpeg-dir=/usr/include/ \
        --with-webp-dir=/usr/include && \
    docker-php-ext-install -j${NPROC} \
        bz2 \
        intl \
        gd \
        opcache \
        pdo_pgsql \
        zip && \
    pecl install \
        amqp \
        apcu \
        xdebug && \
    docker-php-ext-enable \
        amqp \
        apcu \
        xdebug && \
    apk --no-cache del \
        autoconf \
        build-base \
        bzip2-dev \
        icu-dev \
        freetype-dev \
        libjpeg-turbo-dev \
        libpng-dev \
        libwebp-dev \
        libzip-dev \
        postgresql-dev \
        rabbitmq-c-dev && \
    sh -c 'umask 000 && composer global require symfony/flex'

ENV COMPOSER_MEMORY_LIMIT -1

WORKDIR /app
