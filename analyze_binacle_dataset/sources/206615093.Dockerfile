FROM shipito/php:5.6
MAINTAINER Patrik Votocek <patrik@votocek.cz>

RUN pecl install xdebug && \
    docker-php-ext-enable xdebug

ENV COMPOSER_DISABLE_XDEBUG_WARN=1
