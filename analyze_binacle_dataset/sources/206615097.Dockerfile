FROM shipito/php:7.0
MAINTAINER Patrik Votocek <patrik@votocek.cz>

RUN pecl install xdebug && \
    docker-php-ext-enable xdebug

ENV COMPOSER_DISABLE_XDEBUG_WARN=1
