FROM php:7.2-cli

COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

WORKDIR /app
VOLUME /app
