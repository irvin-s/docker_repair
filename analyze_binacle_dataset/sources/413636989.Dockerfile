FROM php:7.1.4-fpm

RUN apt-get -qq update \
    && apt-get -qq install libxml2-dev libpq-dev \
    && docker-php-ext-install pdo xml pgsql

COPY php-fpm/www.conf /etc/php-fpm.d/www.conf
