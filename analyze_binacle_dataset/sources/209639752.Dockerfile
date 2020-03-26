FROM php:7.3
MAINTAINER Krzysztof Kawalec <kf.kawalec@gmail.com>
RUN apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y \
        openssh-client \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libmcrypt-dev \
        libpng-dev \
        libcurl4-openssl-dev \
        libldap2-dev \
        libicu-dev \
        libc-client-dev \
        libkrb5-dev \
        libmagickwand-dev --no-install-recommends \
        curl \
        libtidy* \
        libzip-dev \
        mysql-client \
        gnupg \
        git \
        rsync \
        unzip \
    && apt-get clean \
    && rm -r /var/lib/apt/lists/*

RUN docker-php-ext-install \
        mbstring \
        curl \
        json \
        pdo_mysql \
        exif \
        tidy \
        zip \
        bcmath \
        opcache \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install gd \
    && docker-php-ext-configure ldap --with-libdir=lib/x86_64-linux-gnu \
    && docker-php-ext-install ldap \
    && docker-php-ext-configure intl \
    && docker-php-ext-install intl \
    && docker-php-ext-configure imap --with-kerberos --with-imap-ssl \
    && docker-php-ext-install imap \
    && pecl install imagick \
    && docker-php-ext-enable imagick

RUN echo "memory_limit=-1" > $PHP_INI_DIR/conf.d/memory-limit.ini \
    && echo "date.timezone=Europe/Warsaw" > $PHP_INI_DIR/conf.d/date_timezone.ini

# NodeJS
RUN curl -sL https://deb.nodesource.com/setup_10.x | bash - \
    && apt-get install -y nodejs \
    && apt-get clean

# Yarn
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
    && echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list \
    && apt-get update \
    && apt-get install yarn \
    && apt-get clean

VOLUME /root/composer

ENV COMPOSER_HOME /root/composer

# Install Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer \
    && composer selfupdate
    
WORKDIR /tmp

# Run phpunit installation
RUN composer require "phpunit/phpunit=7.*" --prefer-source --no-interaction \
    && ln -s /tmp/vendor/bin/phpunit /usr/local/bin/phpunit

# Run codesniffer installation
RUN composer require "squizlabs/php_codesniffer=*" --prefer-source --no-interaction \
    && ln -s /tmp/vendor/bin/phpcs /usr/local/bin/phpcs

RUN php --version \
    && composer --version \
    && phpunit --version \
    && phpcs --version \
    && yarn --version
