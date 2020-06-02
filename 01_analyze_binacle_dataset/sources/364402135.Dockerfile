FROM php:7.2-fpm

RUN apt-get update \
  && apt-get install -y --no-install-recommends libpq-dev \
  && docker-php-ext-install pdo_pgsql pdo_mysql
