FROM php:7.0-fpm

# Install Requirements
RUN apt-get update -qq && apt-get install -qqy \
        mysql-client \
        sudo \
        zlib1g-dev \
        libicu-dev \
        libmcrypt-dev \
        wget \
        apt-utils \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libpng12-dev \

    && docker-php-ext-configure intl \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install -j$(nproc) \
       iconv \
       mcrypt \
       intl \
       pdo \
       pdo_mysql \
       mbstring \
       opcache \
       zip \
       gd \
       exif \

    && pecl install apcu \
    && pecl install apcu_bc-1.0.3 \
    && docker-php-ext-enable apcu --ini-name 10-docker-php-ext-apcu.ini \
    && docker-php-ext-enable apc --ini-name 20-docker-php-ext-apc.ini \

    && apt-get purge zlib1g-dev libicu-dev libmcrypt-dev -yy \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

COPY conf/php.ini /usr/local/etc/php/php.ini

COPY script/start.sh /root/start.sh
RUN chmod +x /root/start.sh

CMD ["/bin/bash", "/root/start.sh"]
