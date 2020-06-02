FROM php:5-fpm

MAINTAINER Tom Hanoldt<tom@creative-workflow.berlin>

RUN apt-get update && apt-get install -y php5-mysqlnd \
    libfreetype6-dev \
    libjpeg62-turbo-dev \
    libmcrypt-dev \
    libpng12-dev \
    libicu-dev \
    libxml2-dev \
    libssl-dev \
    curl libcurl3 libcurl3-dev\
    libzip-dev \
    && docker-php-ext-install mysql \
    && docker-php-ext-enable mysql \
    && docker-php-ext-install intl \
    && docker-php-ext-enable intl \
    && docker-php-ext-install gettext \
    && docker-php-ext-enable gettext \
    && docker-php-ext-install curl \
    && docker-php-ext-enable curl \
    && docker-php-ext-install json \
    && docker-php-ext-enable json \
    && docker-php-ext-install mbstring \
    && docker-php-ext-enable mbstring \
    && docker-php-ext-install dom \
    && docker-php-ext-enable dom \
    && docker-php-ext-install mcrypt \
    && docker-php-ext-enable mcrypt \
    && docker-php-ext-install xml \
    && docker-php-ext-enable xml \
    && docker-php-ext-install simplexml \
    && docker-php-ext-enable simplexml \
    && docker-php-ext-install xmlreader \
    && docker-php-ext-enable xmlreader \
    && docker-php-ext-install xmlrpc \
    && docker-php-ext-enable xmlrpc \
    && docker-php-ext-install xmlwriter \
    && docker-php-ext-enable xmlwriter \
    && docker-php-ext-install zip \
    && docker-php-ext-enable zip \
    && docker-php-ext-install mysqli \
    && docker-php-ext-enable mysqli \
    && docker-php-ext-install -j$(nproc) iconv \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install -j$(nproc) gd \
    && docker-php-ext-install opcache \
    && docker-php-ext-enable opcache

RUN { \
    echo 'opcache.memory_consumption=128'; \
    echo 'opcache.interned_strings_buffer=8'; \
    echo 'opcache.max_accelerated_files=4000'; \
    echo 'opcache.revalidate_freq=2'; \
    echo 'opcache.fast_shutdown=1'; \
    echo 'opcache.enable_cli=1'; \
  } > /usr/local/etc/php/conf.d/opcache-recommended.ini
