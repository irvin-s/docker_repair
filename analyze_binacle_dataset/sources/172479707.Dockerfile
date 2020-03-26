FROM php:5.6-apache
MAINTAINER Jim Phillips <jim.phillips@goldenfrogtech.com>

# Update APT
RUN apt-get update

# Prepare PHP5
RUN apt-get install -y openssl libcurl4-openssl-dev libgd-dev libmcrypt-dev \
    && docker-php-ext-install curl gd mcrypt json mysql pdo_mysql

# Enable Rewrite
RUN a2enmod rewrite

# Create App Directory
WORKDIR /var/www/html
ADD . /var/www/html

COPY docker_php.ini /usr/local/etc/php/php.ini
COPY docker_cfg.php cfg.php
