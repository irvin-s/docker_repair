FROM php:5.6-fpm-alpine

# Install php dependencies for Drupal
RUN apk add --no-cache \
      freetype-dev \
      libjpeg-turbo-dev \
      libmcrypt-dev \
      libpng-dev \
      libxml2-dev 

RUN NPROC=$(grep -c ^processor /proc/cpuinfo 2>/dev/null || 1) && docker-php-ext-install -j${NPROC} \
      bcmath \
      iconv \
      mcrypt \
      mbstring \
      opcache \
      hash \
      json \
      pdo \
      session \
      tokenizer \
      xml \
      dom \
      simplexml \
      pdo_mysql

RUN docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/
RUN NPROC=$(grep -c ^processor /proc/cpuinfo 2>/dev/null || 1) && docker-php-ext-install -j${NPROC} gd

COPY conf.d/* /usr/local/etc/php/conf.d/
