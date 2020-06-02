FROM php:7.0
MAINTAINER Krzysztof Kawalec <kf.kawalec@gmail.com>
RUN apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y \
        openssh-client \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libmcrypt-dev \
        libpng12-dev \
        libcurl4-openssl-dev \
        libldap2-dev \
        curl \
        libtidy* \
        git \
    && apt-get clean \
    && rm -r /var/lib/apt/lists/*

RUN docker-php-ext-install \
        mcrypt \
        mbstring \
        curl \
        json \
        pdo_mysql \
        exif \
        tidy \
        zip \
    	&& docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
        && docker-php-ext-install gd \
        && docker-php-ext-configure ldap --with-libdir=lib/x86_64-linux-gnu \
	&& docker-php-ext-install ldap

# Xdebug
RUN pecl install -o -f xdebug \ 
    && rm -rf /tmp/* \ 
    && docker-php-ext-enable xdebug 

RUN echo "memory_limit=-1" > $PHP_INI_DIR/conf.d/memory-limit.ini \
    && echo "date.timezone=Europe/Warsaw" > $PHP_INI_DIR/conf.d/date_timezone.ini

# NodeJS
RUN curl -sL https://deb.nodesource.com/setup_6.x | bash - \
    && apt-get install -y nodejs \
    && apt-get clean

VOLUME /root/composer

ENV COMPOSER_HOME /root/composer

# Install Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer \
	&& composer selfupdate
    
WORKDIR /tmp

# Run phpunit installation
RUN composer require "phpunit/phpunit=5.*" --prefer-source --no-interaction \
    && ln -s /tmp/vendor/bin/phpunit /usr/local/bin/phpunit

# Run codesniffer installation
RUN composer require "squizlabs/php_codesniffer=*" --prefer-source --no-interaction \
    && ln -s /tmp/vendor/bin/phpcs /usr/local/bin/phpcs

RUN php --version \
    && composer --version \
    && phpunit --version \
    && phpcs --version
