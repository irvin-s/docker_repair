ARG TAG=7.3.5-fpm-alpine3.9

FROM php:$TAG

LABEL mantainer="developer@fabriziocafolla.com"
LABEL description="Backend Container"

# ARG EXP=9000

ENV build_deps \
		autoconf \
		libzip-dev \
        libxslt-dev \
        freetype-dev \
        libjpeg-turbo-dev \
        libpng-dev \
        freetype-dev

ENV persistent_deps \
		build-base \
		libxslt \
		libjpeg-turbo \
		libpng \
		freetype \
		unzip \
		php-xml \
		php-zip \
		git \
        mysql-client \
        bash \
        nano

# Set working directory as
WORKDIR /var/www

#Conflict with errors handler
#COPY ./backend/php.ini /usr/local/etc/php/php.ini

# Copy xdebug configuration for remote debugging
COPY ./backend/xdebug.ini /usr/local/etc/php/conf.d/xdebug.ini

RUN sed -i "s/xdebug.remote_autostart=0/xdebug.remote_autostart=1/" /usr/local/etc/php/conf.d/xdebug.ini && \
    sed -i "s/xdebug.remote_enable=0/xdebug.remote_enable=1/" /usr/local/etc/php/conf.d/xdebug.ini && \
    sed -i "s/xdebug.cli_color=0/xdebug.cli_color=1/" /usr/local/etc/php/conf.d/xdebug.ini

# Install build dependencies
RUN apk upgrade && apk update && \
    apk add --no-cache --virtual .build-dependencies $build_deps

# Install persistent dependencies
RUN apk add --update --no-cache --virtual .persistent-dependencies $persistent_deps && \
    printf "\n" | pecl install -o -f redis && \
    rm -rf /tmp/pear && \
    docker-php-ext-enable redis && \
    curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Install docker ext
RUN apk update && \
    docker-php-ext-configure gd \
        --with-gd \
        --with-freetype-dir=/usr/include/ \
        --with-png-dir=/usr/include/ \
        --with-jpeg-dir=/usr/include/ && \
        NPROC=$(grep -c ^processor /proc/cpuinfo 2>/dev/null || 1) && \
        docker-php-ext-install -j${NPROC} gd && \
    docker-php-ext-install mysqli pdo pdo_mysql \
        xsl \
        mbstring \
        zip \
        opcache \
        pcntl

# Run install xdebug and remove build deps
RUN apk update && \
    pecl install xdebug &&\
    docker-php-ext-enable xdebug && \
    apk del .build-dependencies

# EXPOSE $EXP