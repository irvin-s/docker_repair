FROM php:7.0
MAINTAINER Patrik Votocek <patrik@votocek.cz>

ENV COMPOSER_NO_INTERACTION=1 COMPOSER_ALLOW_SUPERUSER=1 COMPOSER_DISCARD_CHANGES=1

RUN apt-get update -yqq && \
    apt-get upgrade -yqq && \
    apt-get install curl git libfcgi-dev libfcgi0ldbl libjpeg62-turbo-dbg \
      libmcrypt-dev libssl-dev libc-client2007e libc-client2007e-dev \
      libxml2-dev libbz2-dev libcurl4-openssl-dev libjpeg-dev libpng12-dev \
      libfreetype6-dev libkrb5-dev libpq-dev libxml2-dev libxslt1-dev \
      libicu-dev -yqq && \
    docker-php-ext-install bz2 && \
    docker-php-ext-install bcmath && \
    docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ && \
    docker-php-ext-install gd && \
    docker-php-ext-install gettext && \
    docker-php-ext-install intl && \
    docker-php-ext-install mbstring && \
    docker-php-ext-install mcrypt && \
    docker-php-ext-install opcache && \
    docker-php-ext-install pcntl && \
    docker-php-ext-install soap && \
    docker-php-ext-install sockets && \
    docker-php-ext-install xsl && \
    docker-php-ext-install zip && \
    docker-php-ext-install pdo_mysql && \
    curl -Lo /usr/local/bin/composer https://getcomposer.org/download/1.3.1/composer.phar && \
    chmod +x /usr/local/bin/composer && \
    curl -Lo /usr/local/bin/victor https://github.com/nella/victor/releases/download/v1.2.1/victor.phar && \
    chmod +x /usr/local/bin/victor && \
    curl -Lo /usr/local/bin/security-checker http://get.sensiolabs.org/security-checker.phar && \
    chmod +x /usr/local/bin/security-checker && \
    echo "memory_limit = -1" >> /usr/local/etc/php/php.ini && \
    echo "opcache.save_comments = 1" >> /usr/local/etc/php/php.ini
