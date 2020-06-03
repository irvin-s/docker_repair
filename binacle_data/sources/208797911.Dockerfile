FROM php:7.0-fpm

ADD ./wordpress.ini /usr/local/etc/php/conf.d
ADD ./wordpress.pool.conf /usr/local/etc/php-fpm.d/

RUN apt-get update && apt-get install -y \
    libfreetype6-dev \
	libjpeg62-turbo-dev \
	libmcrypt-dev \
	libpng12-dev

# Install extensions using the helper script provided by the base image
RUN docker-php-ext-install gd mbstring mysqli

RUN usermod -u 1000 www-data

WORKDIR /var/www/wordpress

CMD ["php-fpm"]

EXPOSE 9000
