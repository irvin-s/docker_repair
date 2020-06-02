FROM php:7-alpine

RUN echo http://dl-5.alpinelinux.org/alpine/edge/community/ >> /etc/apk/repositories

RUN apk add --update --no-cache libintl icu icu-dev zlib-dev autoconf g++ make bash && \
    docker-php-ext-install opcache intl zip

# DEV packages
RUN apk add --update --no-cache git openssh
RUN pecl install xdebug && docker-php-ext-enable xdebug
RUN curl -o /tmp/composer-setup.php https://getcomposer.org/installer && \
    curl -o /tmp/composer-setup.sig https://composer.github.io/installer.sig && \
    php -r "if (hash('SHA384', file_get_contents('/tmp/composer-setup.php')) !== trim(file_get_contents('/tmp/composer-setup.sig'))) { unlink('/tmp/composer-setup.php'); echo 'Invalid installer' . PHP_EOL; exit(1); }" && \
    php /tmp/composer-setup.php --install-dir=/usr/local/bin --filename=composer && \
    rm /tmp/composer-setup.php

RUN rm -rf /var/cache/apk/*
