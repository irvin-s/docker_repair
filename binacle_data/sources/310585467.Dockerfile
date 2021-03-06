FROM php:7.1.8-fpm

LABEL maintainer "i.yatsevich@2gis.ru"
LABEL version = "1.0"
LABEL description = "PHP-FPM-7.1 base image"

WORKDIR /var/www/html/

# Install php-extentions and apk packages
RUN set -xe \
    && apt-get update \
    && apt-get install -y \
        libmcrypt-dev \
        libxml2-dev \
        libicu-dev \
        libpq-dev \
        libcurl4-gnutls-dev \
        git \
    --no-install-recommends \
    && docker-php-ext-install \
        intl \
        pdo_pgsql \
        pcntl \
        mcrypt curl \
        mbstring \
        dom \
        simplexml \
        opcache \
        zip \
    && pecl install -o -f \
        redis-3.1.3 \
        apcu-5.1.8 \
    && docker-php-ext-enable \
        redis \
        apcu \
    && rm -rf /tmp/pear \
    && rm -r /var/lib/apt/lists/*

# Install composer
## Allow Composer to be run as root
ENV COMPOSER_ALLOW_SUPERUSER 1
ENV COMPOSER_PROCESS_TIMEOUT 1800
## Install composer to /usr/bin
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/bin --filename=composer

### Для ускорения работы composer
RUN composer global require hirak/prestissimo

COPY ./src/composer.json composer.json
#COPY ./src/composer.lock composer.lock
# Install dependencies from composer
# Bug: if `composer.json` not found - docker build will be failed
RUN composer install --optimize-autoloader --no-interaction -vvv

RUN mkdir -p /tmp && chown -R www-data:www-data /tmp

USER www-data
