FROM php:7-fpm
MAINTAINER Aliaksandr Harbunou "onekit@gmail.com"
#php modules
RUN apt-get update && apt-get install -y \
    git \
    libfreetype6-dev \
    libjpeg62-turbo-dev \
    libmcrypt-dev \
    libpng-dev \
	libicu-dev \
	libpq-dev \
	mysql-client && \
	docker-php-ext-configure pgsql -with-pgsql=/usr/local/pgsql && \
    docker-php-ext-install pdo pdo_pgsql pgsql && \
	docker-php-ext-install intl && \
    docker-php-ext-install pdo_mysql && \
    docker-php-ext-install zip && \
    docker-php-ext-install exif && \
    pecl install apcu && \
    docker-php-ext-enable apcu && \
    pecl install mcrypt-1.0.1 && \
    docker-php-ext-enable mcrypt && \
    docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ && \
    docker-php-ext-install -j$(nproc) gd
ENV HOME /app
WORKDIR /app
#composer install
ENV COMPOSER_ALLOW_SUPERUSER 1
RUN curl -sS https://getcomposer.org/installer | php -- --filename=composer --install-dir=/usr/local/bin
#copy src to container
COPY . /app
#install symfony project
RUN composer install --no-ansi --no-interaction --no-progress --optimize-autoloader
RUN chown www-data:www-data -R /app /tmp

#wait when MySQL service is UP. Then load fixtures
RUN chmod 755 ./app/config/docker/php-fpm-7/fixtures-pgsql.sh
RUN chmod 755 ./app/config/docker/php-fpm-7/fixtures-mysql.sh
