FROM php:7.2-fpm-alpine

RUN apk add --update postgresql-dev \
    && apk add --update git \
    && apk --update add bash autoconf build-base icu-dev libxml2-dev \
    && docker-php-ext-configure pdo_pgsql \
    && docker-php-ext-install pdo_pgsql \
    && docker-php-ext-configure pcntl \
    && docker-php-ext-configure intl \
    && docker-php-ext-install intl \
    && docker-php-ext-install xml \
    && docker-php-ext-configure xml \
    && docker-php-ext-install pcntl \
    && docker-php-ext-install opcache \
    && echo "opcache.enable_cli=1" >> /usr/local/etc/php/conf.d/docker-php-ext-opcache.ini \
    && yes | pecl install xdebug \
    && docker-php-ext-enable xdebug \
    && echo "xdebug.remote_enable=on" >> /usr/local/etc/php/conf.d/xdebug.ini \
    && echo "xdebug.remote_connect_back=on" >> /usr/local/etc/php/conf.d/xdebug.ini \
    && apk del autoconf build-base \
    && rm -rf /var/cache/apk/*

ADD ./php-overrides.ini /usr/local/etc/php/conf.d/php-overrides.ini

ADD ./php-fpm.conf /etc/php-fpm/php-fpm.conf

RUN mkdir -p /usr/share/php-fpm

EXPOSE 9001

CMD ["php-fpm", "--allow-to-run-as-root", "--fpm-config", "/etc/php-fpm/php-fpm.conf"]
