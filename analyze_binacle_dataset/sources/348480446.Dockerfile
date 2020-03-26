FROM php:7.0-fpm

MAINTAINER Haydar KÜLEKCİ <haydarkulekci@gmail.com>

ADD ./zf2-boilerplate.ini /usr/local/etc/php/conf.d
ADD ./zf2-boilerplate.pool.conf /usr/local/etc/php-fpm.d/

RUN apt-get update && apt-get install -y \
    libpq-dev \
    curl \
    libjpeg-dev \
    libpng12-dev \
    libfreetype6-dev \
    libssl-dev \
    libmcrypt-dev \
    --no-install-recommends \
    && rm -r /var/lib/apt/lists/*

# install mcrypt library
RUN docker-php-ext-install mcrypt

# configure gd library
RUN docker-php-ext-configure gd \
    --enable-gd-native-ttf \
    --with-jpeg-dir=/usr/lib \
    --with-freetype-dir=/usr/include/freetype2

# Install extensions using the helper script provided by the base image
RUN docker-php-ext-install \
    pdo_mysql \
    gd

# Install xdebug
RUN pecl install xdebug \
    && docker-php-ext-enable xdebug

# Install apc
RUN pecl install apcu \
    && echo extension=apcu.so > /usr/local/etc/php/conf.d/apcu.ini

RUN usermod -u 1000 www-data

WORKDIR /var/www/zf2-boilerplate

CMD ["php-fpm"]

EXPOSE 9000
