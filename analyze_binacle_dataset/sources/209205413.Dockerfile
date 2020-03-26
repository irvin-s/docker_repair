FROM php:fpm

ADD ./config/wordpress.ini /usr/local/etc/php/conf.d
ADD ./config/wordpress.pool.conf /usr/local/etc/php-fpm.d/

RUN apt-get update && apt-get install -y \
    libpq-dev \
    curl

# Install extensions using the helper script provided by the base image
RUN docker-php-ext-install mysqli

RUN usermod -u 1000 www-data

WORKDIR /var/www/app

CMD ["php-fpm"]

EXPOSE 9000
