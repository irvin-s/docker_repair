FROM php:7.0-cli
RUN apt-get update && apt-get install -y -qq \
        libgmp-dev libicu-dev \
    && ln -s /usr/include/x86_64-linux-gnu/gmp.h /usr/local/include/ \
    && docker-php-ext-install gmp \
    && docker-php-ext-install intl
RUN \
  echo 'date.timezone="UTC"' > /usr/local/etc/php/conf.d/timezone.ini;
