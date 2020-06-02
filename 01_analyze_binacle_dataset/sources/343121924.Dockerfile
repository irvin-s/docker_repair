FROM php:7.2-fpm-alpine3.7

LABEL maintainer="Angristan https://github.com/Angristan/dockerfiles"

RUN apk update \
    && apk upgrade \
    && apk add --no-cache libpng-dev freetype-dev curl-dev libxml2-dev \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ \
    && docker-php-ext-install mysqli pdo pdo_mysql gd opcache curl xml mbstring zip \
    && echo "expose_php = off" > /usr/local/etc/php/conf.d/custom.ini