FROM php:7.1-fpm

WORKDIR "/app"

COPY ./sources.list /etc/apt/sources.list

# 安装php扩展
RUN apt-get update \
    && mv "$PHP_INI_DIR/php.ini-production" "$PHP_INI_DIR/php.ini" \
    && apt-get install -y --no-install-recommends --assume-yes git zip unzip vim wget curl \
        libfreetype6-dev libjpeg62-turbo-dev libpng-dev libmemcached-dev zlib1g-dev libmagickwand-dev \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install -j$(nproc) gd sockets zip \
    && pecl update-channels \
    && echo -e "\n\n\n\n" | pecl install swoole \
    && echo -e "\n" | pecl install imagick \
    && pecl install memcached \
    && pecl clear-cache \
    && docker-php-ext-enable swoole memcached imagick \
    && apt-get clean && apt-get autoclean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /usr/share/doc/*

# 安装composer
RUN curl --silent https://getcomposer.org/installer | php \
    && mv composer.phar /usr/local/bin/composer \
    && composer config -g repo.packagist composer https://packagist.laravel-china.org \
    && composer global require hirak/prestissimo
