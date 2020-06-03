FROM php:7.2-apache

# enable mod rewrite
RUN a2enmod rewrite

RUN apt-get update
RUN apt-get -y install vim-tiny libicu-dev curl git zip

ENV COMPOSER_ALLOW_SUPERUSER 1
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

RUN docker-php-ext-install bcmath
