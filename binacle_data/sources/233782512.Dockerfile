FROM php:fpm

MAINTAINER Andreas Schlapbach <schlpbch@gmail.com>

RUN apt-get update

RUN apt-get install -y \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libmcrypt-dev \
    && docker-php-ext-install -j$(nproc) iconv pdo pdo_mysql zip \
    && docker-php-ext-configure gd \
        --with-freetype-dir=/usr/include/ \
        --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install -j$(nproc) gd

RUN apt-get install -y libicu-dev \
    && docker-php-ext-install -j$(nproc) intl

#RUN apt-get install git -y \
#    && git clone -b php7 https://github.com/phpredis/phpredis.git /usr/src/php/ext/redis \
#    && docker-php-ext-install -j$(nproc) redis

#Adding MySQL configuration
#COPY redis.ini /etc/php/mods-available/redis.ini
