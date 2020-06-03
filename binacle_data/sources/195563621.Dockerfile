FROM php:5.6-fpm

RUN apt-get update && apt-get install -y \
        php5-curl php5-gd php5-mcrypt php5-mysql php5-intl php5-imagick

RUN docker-php-ext-install mysql mysqli pdo pdo_mysql

COPY ./uploads.ini /usr/local/etc/php/conf.d/uploads.ini