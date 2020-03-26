# ARG PHP_VERSION=${PHP_COMPILE_VERSION}

FROM php:7.1-fpm-alpine

LABEL maintainer="Jun <zhoujun3372@gmail.com>"

# 设置中国源
RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.ustc.edu.cn/g' /etc/apk/repositories

# 设置http为https
RUN sed -i 's/http/https/g' /etc/apk/repositories

RUN apk add --no-cache --virtual .build-deps \
    autoconf \
    file \
    gcc \
    g++ \
    libc-dev \
    make \
    pkgconf \
    re2c

RUN apk add --no-cache --virtual tzdata \
    zlib-dev \
    coreutils \
    supervisor \
    libltdl \
    freetype-dev \
    gettext-dev \
    libjpeg-turbo-dev \
    libpng-dev \
    curl-dev \
    libmcrypt-dev \
    libxml2-dev \
    cyrus-sasl-dev \
    libmemcached-dev \
    hiredis

RUN docker-php-ext-install -j$(nproc) \
    iconv mcrypt gettext curl mysqli pdo pdo_mysql zip \
    mbstring bcmath opcache xml simplexml sockets hash soap exif

# Gd
RUN docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ && docker-php-ext-install -j$(nproc) gd

# Redis
RUN pecl install redis && docker-php-ext-enable redis

# Memcached
RUN pecl install memcached && docker-php-ext-enable memcached

# Swoole
RUN pecl install swoole && docker-php-ext-enable swoole
# RUN && pecl install xdebug-2.5.0 

# 中国时区
RUN cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime  && echo "Asia/Shanghai" >  /etc/timezone

# Composer
RUN curl -sS https://install.phpcomposer.com/installer | php \
    && mv composer.phar /usr/local/bin/composer \
    # && composer config -g repo.packagist composer https://packagist.laravel-china.org \
    && composer self-update --clean-backups

# 清理
RUN apk del .build-deps
RUN rm -rf /var/cache/apk/*
RUN rm -rf /var/lib/apt/lists/* 

# 暴露端口
EXPOSE 9000

# 执行脚本
ENTRYPOINT ["php-fpm"]
