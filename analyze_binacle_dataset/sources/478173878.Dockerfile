#The tools container might be a little bit big here.
#We should probably look into splitting this file.
FROM php:7.1.0RC6

# Environment variable
ENV APCU_VERSION 5.1.2
ENV APCU_BC_VERSION 1.0.0

# Dependencies
RUN apt-get update \
    && apt-get install -y \
        wget \
        libpq-dev \
        libicu-dev \
        git \
        zlib1g-dev \
        redis-tools \
        postgresql-client \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libpng12-dev \
        unzip \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install intl mbstring pgsql pdo_pgsql zip gd \
    && curl -sS https://getcomposer.org/installer | php -- --filename=composer --install-dir=/usr/local/bin \
    && apt-get clean \
    && rm -r /var/lib/apt/lists/*

# APC
RUN git clone --depth 1 -b v$APCU_VERSION https://github.com/krakjoe/apcu.git /usr/src/php/ext/apcu \
    && git clone --depth 1 -b v$APCU_BC_VERSION https://github.com/krakjoe/apcu-bc.git /usr/src/php/ext/apcu_bc \
    && docker-php-ext-configure apcu \
    && docker-php-ext-configure apcu_bc \
    && docker-php-ext-install opcache apcu apcu_bc \
    && mv /usr/local/etc/php/conf.d/docker-php-ext-apc.ini /usr/local/etc/php/conf.d/zz-docker-php-ext-apc.ini \
    && rm -rf /usr/src/php/ext/apcu \
    && rm -rf /usr/src/php/ext/apcu_bc \
    && rm -rf /tmp/* /var/tmp/*

# Xdebug
RUN pecl install -o -f xdebug-2.5.0 \
    && rm -rf /tmp/pear

# Configuration
COPY php.ini /usr/local/etc/php/php.ini
COPY xdebug.ini /usr/local/etc/php/conf.d/xdebug.ini
COPY entrypoint.sh /usr/local/bin/entrypoint.sh

# Access right
RUN mkdir -p /var/www/html

WORKDIR /var/www/html/
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
