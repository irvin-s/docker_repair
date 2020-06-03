FROM composer:1.8.4 as composer
COPY . /shlink-website
RUN cd /shlink-website && \
    composer install --no-dev --optimize-autoloader --apcu-autoloader --prefer-dist --no-interaction --no-progress && \
    rm ./composer.*


FROM node:10.15.3-alpine as node
COPY --from=composer /shlink-website /shlink-website
RUN cd /shlink-website && \
    npm install && \
    ./node_modules/.bin/grunt && \
    rm ./public/assets/css/font-awesome.min.css && \
    rm ./public/assets/css/highlightjs-github.min.css && \
    rm ./public/assets/css/main.css && \
    rm ./public/assets/js/jquery.min.js && \
    rm ./public/assets/js/jquery.scrolly.min.js && \
    rm ./public/assets/js/highlight.pack.js && \
    rm ./public/assets/js/skel.min.js && \
    rm ./public/assets/js/main.js && \
    rm ./package.json && \
    rm ./package-lock.json && \
    rm -r node_modules && \
    rm ./Gruntfile.js


FROM php:7.3.4-fpm-alpine3.9
LABEL maintainer="Alejandro Celaya <alejandro@alejandrocelaya.com>"
COPY --from=node /shlink-website /shlink-website

ENV APCu_VERSION 5.1.16
ENV APCuBC_VERSION 1.0.4

# Install APCu extension
RUN wget "https://pecl.php.net/get/apcu-${APCu_VERSION}.tgz" -O /tmp/apcu.tar.gz && \
    mkdir -p /usr/src/php/ext/apcu && \
    tar xf /tmp/apcu.tar.gz -C /usr/src/php/ext/apcu --strip-components=1 && \
    docker-php-ext-configure apcu && \
    docker-php-ext-install -j"$(nproc)" apcu && \
    rm /tmp/apcu.tar.gz

# Install APCu-BC extension
RUN wget "https://pecl.php.net/get/apcu_bc-${APCuBC_VERSION}.tgz" -O /tmp/apcu_bc.tar.gz && \
    mkdir -p /usr/src/php/ext/apcu-bc && \
    tar xf /tmp/apcu_bc.tar.gz -C /usr/src/php/ext/apcu-bc --strip-components=1 && \
    docker-php-ext-configure apcu-bc && \
    docker-php-ext-install -j"$(nproc)" apcu-bc && \
    rm /tmp/apcu_bc.tar.gz

# Load APCU.ini before APC.ini
RUN rm /usr/local/etc/php/conf.d/docker-php-ext-apcu.ini && \
    echo extension=apcu.so > /usr/local/etc/php/conf.d/20-php-ext-apcu.ini
