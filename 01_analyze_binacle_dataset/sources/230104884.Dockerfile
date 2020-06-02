FROM php:7-cli
MAINTAINER Armin Braun

RUN apt-get update && apt-get install -y mysql-client libmysqlclient-dev curl git \
    libfreetype6-dev libjpeg62-turbo-dev libmcrypt-dev libpng12-dev \
    && docker-php-ext-install iconv mcrypt \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install gd \
    && docker-php-ext-install zip \
    && docker-php-ext-install mysqli \
    && docker-php-ext-install opcache \
    && docker-php-ext-install mbstring 

#COMPOSER 
RUN curl -sS https://getcomposer.org/installer | php
RUN mv composer.phar /usr/local/bin/composer

#PHPUNIT
RUN composer global require "phpunit/phpunit"

ENV PATH /root/.composer/vendor/bin:$PATH

RUN ln -s /root/.composer/vendor/bin/phpunit /usr/bin/phpunit
