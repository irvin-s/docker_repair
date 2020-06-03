FROM php:5.6-cli
RUN apt-get update && apt-get install -y -qq \
        libgmp-dev libicu-dev \
    && ln -s /usr/include/x86_64-linux-gnu/gmp.h /usr/local/include/ \
    && docker-php-ext-install gmp \
    && docker-php-ext-install intl
RUN \
  echo "memory_limit = 512M" > /usr/local/etc/php/conf.d/memory.ini; \
  echo 'date.timezone="UTC"' > /usr/local/etc/php/conf.d/timezone.ini
