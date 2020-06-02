FROM php:7.1-fpm

# install php extensions laravel needs
RUN apt-get update && \
    docker-php-ext-install pdo_mysql && \
    apt-get install -y curl git zlib1g-dev && \
    docker-php-ext-install zip

# install grpc extension for php
RUN pecl install grpc\
    && docker-php-ext-enable grpc 

# install composer, install deps with composer as per composer.json
RUN curl -sS https://getcomposer.org/installer | php
RUN mv composer.phar /usr/local/bin/composer
RUN composer self-update