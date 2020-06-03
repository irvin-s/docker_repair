FROM php

ADD . /preprocess
WORKDIR /preprocess

RUN apt-get update
RUN apt-get install -y git
RUN apt-get install -y zip unzip
RUN apt-get install -y zlib1g-dev

RUN docker-php-ext-install mbstring
RUN docker-php-ext-install zip

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin

ENV COMPOSER_ALLOW_SUPERUSER 1
RUN composer.phar update
