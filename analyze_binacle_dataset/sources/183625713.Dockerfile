FROM php:5.6-apache

RUN apt-get update \
    && apt-get install -y git  zlib1g-dev \
    && docker-php-ext-install mysql pdo_mysql zip

ADD docker/vhost.conf /etc/apache2/sites-enabled/000-default.conf
ADD docker/php.ini /usr/local/etc/php/php.ini

RUN a2enmod rewrite

RUN curl -sS https://getcomposer.org/installer | php \
    && mv composer.phar /usr/bin/composer

WORKDIR /var/www/wordpress
