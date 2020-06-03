FROM php:7.3-fpm
LABEL maintainer="Wouter De Schuyter <wouter.de.schuyter@gmail.com>"

RUN apt-get update && \
  # Some basic extensions
  docker-php-ext-install -j$(nproc) json mbstring opcache pdo pdo_mysql mysqli && \
  # Curl
  apt-get install -y libcurl4-openssl-dev && \
  docker-php-ext-install -j$(nproc) curl && \
  apt-get purge libcurl4-openssl-dev -y && \
  # GD
  apt-get install -y libpng-dev libjpeg-dev && \
  docker-php-ext-install -j$(nproc) gd && \
  apt-get purge libpng-dev libjpeg-dev -y && \
  # Intl
  apt-get install -y libicu-dev && \
  docker-php-ext-install -j$(nproc) intl && \
  apt-get purge libicu-dev -y && \
  # More cleanup
  apt-get autoremove --purge -y && \
  apt-get clean
