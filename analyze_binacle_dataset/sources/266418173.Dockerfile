FROM php:latest

# APT packages
RUN apt-get update && apt-get install -y \
    zlib1g-dev \
    git \
    && rm -rf /var/lib/apt/lists/*

RUN docker-php-ext-install opcache

## PHP configuration
COPY php.ini /usr/local/etc/php/php.ini

# APCU extension
RUN pecl install apcu \
    && docker-php-ext-enable apcu \
    && rm -rf /tmp/pear

WORKDIR /opt/serializer-benchmark
