FROM php:5.6-apache
MAINTAINER Maksym Prokopov<mprokopov@gmail.com>

RUN apt-get update && apt-get install -y libpng12-dev libjpeg-dev libmcrypt-dev unzip git \
    && rm -rf /var/lib/apt/lists/* \
    && docker-php-ext-configure gd --with-png-dir=/usr --with-jpeg-dir=/usr \
    && docker-php-ext-install gd mcrypt mbstring mysqli pdo_mysql zip

RUN a2enmod rewrite actions

ENV VERSION 3254
ENV DIST e2_distr_v${VERSION}.zip
ENV URL https://blogengine.ru/download/${DIST}

RUN curl -O $URL && unzip $DIST -d /var/www/html

EXPOSE 80
