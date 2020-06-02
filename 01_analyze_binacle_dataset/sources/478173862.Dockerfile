FROM php:7.1.0RC6-fpm

# Environment variable
ENV APCU_VERSION 5.1.2
ENV APCU_BC_VERSION 1.0.0

# Dependencies
RUN apt-get update \
    && apt-get install -y \
        libpq-dev \
        libicu-dev \
        zlib1g-dev \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libpng12-dev \
        git \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install intl mbstring pgsql pdo_pgsql zip gd \
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

#Blackfire
RUN export VERSION=`php -r "echo PHP_MAJOR_VERSION.PHP_MINOR_VERSION;"` \
    && curl -A "Docker" -o /tmp/blackfire-probe.tar.gz -D - -L -s https://blackfire.io/api/v1/releases/probe/php/linux/amd64/${VERSION} \
    && tar zxpf /tmp/blackfire-probe.tar.gz -C /tmp \
    && mv /tmp/blackfire-*.so `php -r "echo ini_get('extension_dir');"`/blackfire.so \
    && echo "extension=blackfire.so" > $PHP_INI_DIR/conf.d/blackfire.ini \
    && echo "blackfire.agent_socket=\${BLACKFIRE_PORT}" >> $PHP_INI_DIR/conf.d/blackfire.ini

# Configuration
COPY php.ini /usr/local/etc/php/php.ini
COPY xdebug.ini /usr/local/etc/php/conf.d/xdebug.ini
COPY entrypoint.sh /usr/local/bin/entrypoint.sh

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
