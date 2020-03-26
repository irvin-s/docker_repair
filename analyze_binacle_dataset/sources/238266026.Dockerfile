FROM php:7-apache

MAINTAINER Thiago Rodrigues <thiago.rodrigues@upx.com.br>

RUN apt-get update && apt-get install -y libfreetype6-dev libjpeg62-turbo-dev \
        libmcrypt-dev libpng12-dev git vim curl \
    && docker-php-ext-install -j$(nproc) iconv mcrypt zip

RUN pecl install xdebug && docker-php-ext-enable xdebug

RUN a2enmod rewrite

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer