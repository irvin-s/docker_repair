ARG COMPOSER_VERSION=latest  
ARG PHP_VERSION=7.2-alpine  
  
FROM composer:${COMPOSER_VERSION} as composer  
WORKDIR /build  
RUN cp /usr/bin/composer .  
  
FROM php:${PHP_VERSION}  
WORKDIR /app  
COPY \--from=composer /build/composer /usr/bin/composer  
RUN apk update \  
&& apk add git wget zip unzip zlib-dev make \  
&& docker-php-ext-install pcntl zip mbstring pdo_mysql  

