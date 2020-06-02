FROM php:7.1-fpm

MAINTAINER Paulo Dias <prbdias@gmail.com>

COPY ./php.ini /usr/local/etc/php/

RUN apt-get update && apt-get install -y \
    libpq-dev \
    curl

# Install extensions using the helper script provided by the base image
RUN docker-php-ext-install \
    pdo_mysql \
    pdo_pgsql

RUN usermod -u 1000 www-data

WORKDIR /var/www

CMD ["php-fpm"]

EXPOSE 9000
