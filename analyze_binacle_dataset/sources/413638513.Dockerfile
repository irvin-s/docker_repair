FROM php:7.1-apache

RUN pecl install redis-3.1.4 \
    && docker-php-ext-enable redis

RUN docker-php-ext-install mysqli pdo_mysql
