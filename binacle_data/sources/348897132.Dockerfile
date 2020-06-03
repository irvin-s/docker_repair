FROM php:7-alpine

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/bin --filename=composer

RUN export COMPOSER_DISABLE_XDEBUG_WARN=1
