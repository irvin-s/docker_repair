FROM php:7.0-cli
RUN pecl install xdebug && docker-php-ext-enable xdebug