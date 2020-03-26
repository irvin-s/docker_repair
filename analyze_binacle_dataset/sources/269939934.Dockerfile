FROM php:7.1-fpm
MAINTAINER Adil YASSINE <adilyassine.info>

RUN apt-get update && apt-get install -y  zlib1g-dev libicu-dev libpq-dev imagemagick git mysql-client\
	&& docker-php-ext-install opcache \
	&& docker-php-ext-install intl \
	&& docker-php-ext-install mbstring \
	&& docker-php-ext-install pdo_mysql \
	&& php -r "readfile('https://getcomposer.org/installer');" | php -- --install-dir=/usr/local/bin --filename=composer \
	&& chmod +sx /usr/local/bin/composer
EXPOSE 9000
