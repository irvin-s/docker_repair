FROM php:5.6-cli

RUN apt update \
    && apt -y install \
      git \
      libicu-dev \
      libmcrypt-dev \
      mysql-client \
      libfreetype6-dev \
      libjpeg62-turbo-dev \
      libpng12-dev \
      libxml2-dev \
      libxslt1-dev \
      zip \
      unzip \
    && rm -rf /var/lib/apt/lists/*

RUN curl -sS https://getcomposer.org/installer | php \
    && mv composer.phar /usr/local/bin/composer \
    && rm -f /tmp/composer-setup.php


WORKDIR /code
