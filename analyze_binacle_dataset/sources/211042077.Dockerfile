FROM php:7.2-cli

RUN mkdir /app && apt-get update -y && apt-get install -y libicu-dev && docker-php-ext-install -j$(nproc) intl

WORKDIR /app
