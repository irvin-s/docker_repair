FROM php:5.6-apache

MAINTAINER Tim Petter <tim@timpetter.de>

ENV VERSION v2.3.0

RUN apt-get update && apt-get install -y \
        libfreetype6-dev \
        php5-curl \
        libjpeg62-turbo-dev \
        libmcrypt-dev \
        libpng12-dev \
        git \
    && curl -sS https://getcomposer.org/installer | php \
    && mv composer.phar /usr/local/bin/composer \
    && docker-php-ext-install mbstring mcrypt \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install gd

WORKDIR /var/www/html

RUN git clone https://github.com/hillelcoren/invoice-ninja.git /var/www/html/ \
    && git checkout $VERSION \
    && composer install

EXPOSE 80
