FROM php:7.2.0-fpm-alpine

MAINTAINER liyu liyu001989@gmail.com

RUN apk update && apk upgrade

# gd 扩展
RUN apk add libjpeg-turbo-dev
RUN apk add libpng-dev
RUN docker-php-ext-install gd

# pdo_mysql 扩展
RUN docker-php-ext-install pdo_mysql

RUN docker-php-ext-install zip

# 配置php.ini, 项目中是默认的，可自行配置
COPY config/php.ini /usr/local/etc/php/
