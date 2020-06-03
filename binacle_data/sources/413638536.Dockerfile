FROM php:7.2-apache

RUN apt-get update && apt-get -qq install -y --no-install-recommends vim tree zlib1g-dev libmemcached-dev
RUN docker-php-ext-install pdo_mysql
RUN pecl install memcached
RUN docker-php-ext-enable memcached

COPY docker-php-ext-memcached.ini /usr/local/etc/php/conf.d/docker-php-ext-memcached.ini
