FROM php:7.0-fpm

WORKDIR /var/www

ENV PHPREDIS_VERSION 2.2.7
ENV NGINX_VERSION 1.9.9-1~jessie

# Install System Dependencies
RUN apt-key adv --keyserver hkp://pgp.mit.edu:80 --recv-keys 573BFD6B3D8FBC641079A6ABABF5BD827BD9BF62 \
        && echo "deb http://nginx.org/packages/mainline/debian/ jessie nginx" >> /etc/apt/sources.list \
        && apt-get update \
        && apt-get install -y ca-certificates nginx=${NGINX_VERSION} nano wget git \
        && apt-get clean && apt-get purge \
        && rm -rf /var/lib/apt/lists/* /var/cache/apt/*

# Install PHP extensions
RUN curl -L -o /tmp/redis.tar.gz https://github.com/phpredis/phpredis/archive/$PHPREDIS_VERSION.tar.gz \
        && tar xfz /tmp/redis.tar.gz \
        && rm -r /tmp/redis.tar.gz \
        && mv phpredis-$PHPREDIS_VERSION /usr/src/php/ext/redis \
        && docker-php-ext-install redis pdo_pgsql pgsql soap gd zip mbstring sockets \
        && docker-php-ext-enable redis pdo_pgsql pgsql soap gd zip mbstring sockets \
        && pecl install xdebug && echo ";zend_extension=xdebug.so" > /usr/local/etc/php/conf.d/xdebug.ini \
        && pecl install apcu-4.0.10 && echo extension=apcu.so > /usr/local/etc/php/conf.d/apcu.ini

        
