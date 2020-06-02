FROM php:7.3-fpm-stretch

# Chinese mirror
ADD sources.list /etc/apt/sources.list

RUN apt-get update && apt-get install -y \
    vim \
    lrzsz \
    libjpeg-dev \
    libpng-dev \
    zlib1g-dev \
    libzip-dev \
    libfreetype6-dev \
    libjpeg62-turbo-dev \
    libmcrypt-dev \
    libsasl2-dev \
    libmemcached-dev \
    libicu-dev \
    mysql-client \
    libgmp3-dev \
    libzip4 \
    procps \
    zip \
    unzip \
    git \
    && docker-php-ext-install gmp \
    pdo_mysql \
    iconv \
    intl \
    pcntl \
    opcache \
    bcmath \
    mbstring \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install gd \
    && pecl update-channels \
    # && pecl install mcrypt-1.0.1 && docker-php-ext-enable mcrypt \
    #&& pecl install memcached && docker-php-ext-enable memcached \
    && pecl install redis && docker-php-ext-enable redis

# PHP config
ADD php.ini /usr/local/etc/php/php.ini
ADD php-fpm.conf /usr/local/etc/php-fpm.conf

# OPcache
COPY opcache.ini /home/opcache.ini
RUN cat /home/opcache.ini >> /usr/local/etc/php/conf.d/docker-php-ext-opcache.ini

# Swoole
RUN apt-get install -y libpcre3 libpcre3-dev libssl-dev
RUN pecl install swoole-4.3.1 && docker-php-ext-enable swoole

# Install composer
COPY composer.phar /usr/local/bin/composer
RUN chmod +x /usr/local/bin/composer

# Chinese mirror
RUN /usr/local/bin/composer config -g repo.packagist composer https://packagist.laravel-china.org

# Write Permission
RUN usermod -u 1000 www-data

# Create directory
RUN mkdir /docker/www -p
RUN mkdir /docker/log/php7 -p

RUN chown -R www-data.www-data /docker/www /docker/log/php7

RUN touch /docker/log/php7/php_errors.log && chmod 777 /docker/log/php7/php_errors.log

CMD ["php-fpm"]