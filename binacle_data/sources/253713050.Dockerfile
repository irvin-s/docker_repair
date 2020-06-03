FROM php:5.6-fpm

MAINTAINER Michał Kruczek <mkruczek@pgs-soft.com>

RUN mkdir -p /var/www && \
    chmod 777 -R /var/www

RUN apt-get -qq update --fix-missing && \
    apt-get -qq install -y \
        zlib1g-dev \
        libicu-dev \
        g++ \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libmcrypt-dev \
        libpng12-dev \
        libxml2-dev \
        libxslt1-dev \
        libc-client-dev \
        libkrb5-dev \
        cloc \
        git-core \
        && rm -rf /var/lib/apt/lists/*

COPY docker-php-pecl-install /usr/local/bin/

RUN docker-php-ext-configure imap --with-imap-ssl --with-kerberos \
    && docker-php-ext-install iconv intl mysqli gd mbstring pdo_mysql xsl opcache imap zip \
    && docker-php-pecl-install xdebug-2.5.5 \
    && chown www-data:www-data /usr/local/etc/php/conf.d/docker-php-pecl-xdebug.ini

RUN curl -sS https://getcomposer.org/installer | php \
    && mv composer.phar /usr/local/bin/composer \
    && chmod +x /usr/local/bin/composer

RUN curl -L http://www.phing.info/get/phing-latest.phar -o phing-latest.phar \
    && mv phing-latest.phar /usr/local/bin/phing \
    && chmod +x /usr/local/bin/phing

COPY php.ini /usr/local/etc/php
COPY entrypoint.sh /entrypoint.sh

VOLUME /var/www
WORKDIR /var/www

ENTRYPOINT ["/bin/bash", "/entrypoint.sh"]
