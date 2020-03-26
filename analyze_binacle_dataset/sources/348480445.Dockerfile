FROM php:5.6-fpm

MAINTAINER Haydar KÜLEKCİ <haydarkulekci@gmail.com>

ADD ./zf2-boilerplate.ini /usr/local/etc/php/conf.d
ADD ./zf2-boilerplate.pool.conf /usr/local/etc/php-fpm.d/

RUN apt-get update && apt-get install -y \
    libpq-dev \
    curl \
    libpng12-dev \
    libfreetype6-dev \
    libssl-dev \
    libmcrypt-dev \
    libicu-dev \
    --no-install-recommends \
    && rm -r /var/lib/apt/lists/*

# install mcrypt library
RUN docker-php-ext-install mcrypt

# configure gd library
RUN docker-php-ext-configure gd \
    --enable-gd-native-ttf \
    --with-freetype-dir=/usr/include/freetype2

# Install extensions using the helper script provided by the base image
RUN docker-php-ext-install \
    pdo_mysql \
    gd

# Install xdebug
RUN pecl install xdebug \
    && docker-php-ext-enable xdebug

# Install apcu
RUN pecl install apcu-4.0.11 \
    && docker-php-ext-enable apcu

RUN pecl install intl \
    && docker-php-ext-enable intl

RUN usermod -u 1000 www-data

WORKDIR /var/www/zf2-boilerplate

CMD ["php-fpm"]

EXPOSE 9000
