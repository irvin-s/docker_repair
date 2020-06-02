FROM php:7.1.10-fpm

# --- SOFT --- #

RUN apt-get update && apt-get install -y \
    openssh-client \
    libfreetype6-dev \
    libjpeg62-turbo-dev \
    libmcrypt-dev \
    libpng12-dev \
    zlib1g-dev \
    libssl-dev \
    g++ \
    libmemcached-dev \
    imagemagick \
    libmagickwand-6.q16-dev --no-install-recommends \
    wget && \
    apt-get clean && \
    rm -r /var/lib/apt/lists/*

RUN ln -s /usr/lib/x86_64-linux-gnu/ImageMagick-6.8.9/bin-Q16/MagickWand-config /usr/bin

# --- ICU --- #

RUN mkdir /opt/tmp && cd /opt/tmp && \
    wget http://download.icu-project.org/files/icu4c/58.2/icu4c-58_2-src.tgz && \
    tar zxvf icu4c-58_2-src.tgz && \
    cd icu/source && \
    ./configure --prefix=/opt/icu582 && make && make install && \
    rm -rf /opt/tmp

# --- EXTENSIONS --- #

RUN docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ && \
    docker-php-ext-install gd && \
    docker-php-ext-install pdo && \
    docker-php-ext-install pdo_mysql && \
    docker-php-ext-install opcache && \
    docker-php-ext-configure intl --with-icu-dir=/opt/icu582 && \
    docker-php-ext-install intl && \
    docker-php-ext-install mbstring && \
    docker-php-ext-install fileinfo && \
    docker-php-ext-install dom && \
    docker-php-ext-install zip

RUN pecl channel-update pecl.php.net && \
    pecl install memcached && \
    pecl install imagick

RUN echo "extension=memcached.so" > /usr/local/etc/php/conf.d/ext-memcached.ini && \
    echo "extension=imagick.so" > /usr/local/etc/php/conf.d/ext-imagick.ini

# --- NODE --- #

RUN curl -sL https://deb.nodesource.com/setup_8.x | bash -
RUN apt-get install -y nodejs

# --- COMPOSER --- #

RUN curl -sS https://getcomposer.org/installer | php
RUN mv composer.phar /usr/local/bin/composer

# --- DATA --- #

WORKDIR /var/www/html
