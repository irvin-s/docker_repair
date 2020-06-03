FROM php:7.0-fpm

MAINTAINER Denis-Florin Rendler <denis.rendler@evozon.com>

# install some bare necessities
RUN apt-get update && apt-get install -y \
    libssl-dev \
    libmcrypt-dev \
    libjpeg62-turbo-dev \
    libpng12-dev \
    libfreetype6-dev \
    libpq-dev \
    zlib1g-dev \
    libicu-dev \
    libxslt-dev \
    curl \
    ssh \
    vim \
    git \
    openssl \
    g++ \
    --no-install-recommends \
    && rm -r /var/lib/apt/lists/*

# configure libraries
RUN docker-php-ext-configure gd \
    --enable-gd-native-ttf \
    --with-freetype-dir=/usr/include/freetype2 \
    --with-jpeg-dir=/usr/lib/x86_64-linux-gnu/ \
    && docker-php-ext-configure intl \
    && docker-php-ext-configure hash --with-mhash

# install required extensions
RUN docker-php-ext-install \
    bcmath \
    gd \
    intl \
    mcrypt \
    pdo_mysql \
    xsl \
    zip \
    json \
    iconv \
    soap

# add XDebug for the dev env build
RUN pecl install xdebug  \
    && docker-php-ext-enable xdebug

# expose the xdebug port on dev build
ENV XDEBUG_EXPOSE_PORT ${XDEBUG_PORT:-9000}
EXPOSE $XDEBUG_EXPOSE_PORT

# configure app folder
ENV WORK_DIR ${WORK_DIR:-/www/project}
WORKDIR $WORK_DIR

# Install Composer
RUN curl -s http://getcomposer.org/installer | php \
    && mv composer.phar /usr/local/bin/composer

VOLUME "/usr/local/etc/php/conf.d"
