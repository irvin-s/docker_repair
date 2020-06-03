FROM php:7.2-fpm-alpine

LABEL maintainer="Webber Takken <webber@takken.io>"

RUN curl --insecure https://getcomposer.org/composer.phar -o /usr/bin/composer && chmod +x /usr/bin/composer

RUN apk add --no-cache \
      $PHPIZE_DEPS \
      zlib-dev \
      icu-dev \
      freetype-dev \
      libjpeg-turbo-dev \
      libpng-dev \
    # postgresql-dev \
  && pecl install \
      redis-3.1.6 \
    # apcu \
    # mongodb \
  && docker-php-ext-configure \
      gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
  && docker-php-ext-enable \
      redis \
    # apcu \
    # mongodb \
  && docker-php-ext-install -j$(nproc) \
      intl \
      pdo_mysql \
    # pdo_pgsql \
      opcache \
      gd \
  && rm -rf /var/cache/apk/* && rm -rf /tmp/*

RUN php -m && php -i | grep 'PHP Version\|Redis Version\|SSL Version'

CMD composer install && php-fpm

WORKDIR /var/www/app

EXPOSE 9000
