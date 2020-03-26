FROM php:fpm

RUN docker-php-ext-install mbstring mysqli pdo_mysql

WORKDIR /code

RUN chmod -R 777 .