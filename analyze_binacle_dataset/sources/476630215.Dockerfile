FROM php:5.6-fpm

RUN apt-get update && apt-get install -y zlib1g-dev \
  && docker-php-ext-install -j$(nproc) pdo pdo_mysql zip
