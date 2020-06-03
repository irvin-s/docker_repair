FROM php:7.1-cli

RUN apt-get update \
    && apt-get -y install git


RUN docker-php-ext-install pdo pdo_mysql pcntl

RUN apt-get clean; rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /usr/share/doc/*