FROM php:5.6-apache
MAINTAINER Jim Phillips <jim.phillips@goldenfrogtech.com>

# Update APT
RUN apt-get update


# Prepare PHP5
RUN apt-get install -y openssl libcurl4-openssl-dev libgd-dev libmcrypt-dev libfreetype6-dev libjpeg62-turbo-dev libpng12-dev
RUN docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include \
    && docker-php-ext-install curl gd mcrypt json mysql pdo_mysql
RUN cd /usr/src \
    && curl -L -o /tmp/redis.tar.gz https://github.com/phpredis/phpredis/archive/2.2.7.tar.gz \
    && tar xfz /tmp/redis.tar.gz \
    && rm -r /tmp/redis.tar.gz \
    && cd phpredis-2.2.7 \
    && phpize \
    && ./configure \
    && make install \
    && echo "extension=redis.so" > /usr/local/etc/php/conf.d/redis.ini
    
# Enable Rewrite
RUN a2enmod rewrite

# Create App Directory
WORKDIR /var/www/html
ADD . /var/www
RUN rmdir /var/www/html && mv -f /var/www/htdocs /var/www/html

COPY docker_php.ini /usr/local/etc/php/php.ini
COPY docker_cfg.php /var/www/cfg.php
