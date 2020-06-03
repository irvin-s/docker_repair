FROM php:7.2-apache

RUN apt-get update && apt-get install -y \
        libmcrypt-dev zlib1g-dev libicu-dev g++ \
    && docker-php-ext-install iconv pdo_mysql intl zip mysqli \
    && pecl install xdebug \
    && pecl install apcu-5.1.3 \
    && docker-php-ext-enable xdebug \
    && docker-php-ext-enable mysqli

RUN curl -sS https://getcomposer.org/installer | php \
    && mv composer.phar /usr/bin/composer

COPY apache2.conf /etc/apache2/apache2.conf
COPY php.ini /usr/local/etc/php/php.ini

RUN usermod -u 1000 www-data

RUN a2enmod rewrite alias
RUN service apache2 restart

WORKDIR /var/www/html
