FROM ubuntu:xenial

ENV DEBIAN_FRONTEND=noninteractive

RUN : \
    && apt-get update -qq \
    && apt-get install -y --no-install-recommends software-properties-common \
    && LC_ALL=C.UTF-8 add-apt-repository ppa:ondrej/php \
    ;

RUN : \
    && apt-get update -qq \
    && apt-get install -y --no-install-recommends \
        php7.1-fpm \
        php7.1-cli \
        php7.1-mbstring \
        php7.1-intl \
        php7.1-gd \
        php7.1-mysql \
        php7.1-pgsql \
        php7.1-sqlite \
        php7.1-xml \
        php7.1-memcached \
        php7.1-zip \
        php7.1-curl \
        nginx \
        cron \
        curl \
        git \
        unzip \
        rsync \
    ;

RUN curl -sS https://getcomposer.org/installer | php -- --filename=composer.phar --install-dir=/usr/local/bin

ADD .docker/image/usr /usr

WORKDIR /home/ubuntu/app

ARG WUID

ARG WGID

RUN : \
    && usermod -u ${WUID:-33} -s /bin/bash -d /home/ubuntu www-data \
    && groupmod -g ${WGID:-33} www-data \
    && chown -R www-data:www-data /home/ubuntu \
    && mkdir /run/php /var/log/php \
    ;

COPY --chown=www-data:www-data app/composer.* ./

RUN composer install --prefer-dist --optimize-autoloader

ADD .docker/image/etc /etc

ADD --chown=www-data:www-data app .
