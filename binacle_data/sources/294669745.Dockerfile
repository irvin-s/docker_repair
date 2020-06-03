FROM php:__PHP_VERSION__-apache

RUN apt-get update \
  && apt-get install --no-install-recommends -y \
     libpng12-dev \
     libfreetype6-dev \
     libjpeg-dev \
     mysql-client \
     vim \
     ant \
     unzip \
     git \
     netcat \
     htop

RUN docker-php-ext-configure gd --with-jpeg-dir=/usr/lib \
  && docker-php-ext-install pdo pdo_mysql mbstring gd zip

RUN a2enmod rewrite

COPY vendor/shopware/plugin-dev-tools/bin/wait-mysql.sh /tmp/wait-mysql.sh
COPY vendor/shopware/plugin-dev-tools/output/create-user.sh /tmp/create-user.sh
RUN chmod +x /tmp/create-user.sh
RUN /tmp/create-user.sh

WORKDIR __PLUGIN_WORKDIR__