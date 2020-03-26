FROM php:7.2-fpm

RUN apt-get update

# Install iconv, mcryot, gd
RUN apt-get update && apt-get install -y \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libmcrypt-dev \
        libpng-dev \
    && docker-php-ext-install -j$(nproc) iconv \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install -j$(nproc) gd \
    && pecl install mcrypt-1.0.1 \
    && docker-php-ext-enable mcrypt

# Install memcached
RUN apt-get install -y \
    libmemcached-dev \
    git \
  && git clone https://github.com/php-memcached-dev/php-memcached /usr/src/php/ext/memcached \
  && cd /usr/src/php/ext/memcached && git checkout -b php7 origin/php7 \
  && docker-php-ext-configure memcached \
  && docker-php-ext-install memcached

# Install intl
RUN apt-get install -y \
        libicu-dev \
        zlib1g-dev \
        g++ \
    && docker-php-ext-configure intl \
    && docker-php-ext-install intl

# Install mbstring
RUN docker-php-ext-install mbstring

# Install curl
RUN apt-get install -y libcurl4-openssl-dev \
    && docker-php-ext-install curl

# Install zip
RUN docker-php-ext-install zip

# Install json
RUN docker-php-ext-install json

# Install extensions through the scripts the container provides
# Here we install the pdo_mysql extensions to access MySQL.
RUN docker-php-ext-install pdo pdo_mysql opcache

#MySQLi
RUN docker-php-ext-install mysqli 
RUN docker-php-ext-enable mysqli

# install xdebug
RUN pecl install xdebug
RUN docker-php-ext-enable xdebug \
    && echo "xdebug.idekey = \"docker\"" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini \
    && echo "error_reporting = E_ALL" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini \
    && echo "display_startup_errors = On" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini \
    && echo "display_errors = On" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini \
    && echo "xdebug.remote_enable = on" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini \
    && echo "xdebug.remote_handler=dbgp" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini \
    && echo "xdebug.remote_connect_back = 0" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini \
    && echo "xdebug.var_display_max_depth=10" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini \
    && echo "xdebug.var_display_max_children=256" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini \
    && echo "xdebug.var_display_max_data=1024" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini \
    && echo "xdebug.remote_autostart=on" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini \
    && echo "xdebug.remote_port = 9000" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini

#opcache.validate_timestamps - production environments: 0
RUN usermod -u 1000 www-data
RUN echo 'date.timezone="America/Sao_Paulo"' >> /usr/local/etc/php/conf.d/date.ini
RUN echo 'opcache.enable=1' >> /usr/local/etc/php/conf.d/opcache.conf
RUN echo 'opcache.validate_timestamps=1' >> /usr/local/etc/php/conf.d/opcache.conf
RUN echo 'opcache.fast_shutdown=1' >> /usr/local/etc/php/conf.d/opcache.conf
