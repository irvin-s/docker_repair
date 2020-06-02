FROM php:7.2-apache

# Install debian dependencies
RUN apt-get update \
    && apt-get install -q -y zip unzip git

# Modify document root to be /public
ENV APACHE_DOCUMENT_ROOT /var/www/sleeti/public

RUN sed -ri -e 's!/var/www/html!${APACHE_DOCUMENT_ROOT}!g' /etc/apache2/sites-available/*.conf \
    && sed -ri -e 's!/var/www/!${APACHE_DOCUMENT_ROOT}!g' /etc/apache2/apache2.conf /etc/apache2/conf-available/*.conf

# Enable PDO MySQL drivers
RUN docker-php-ext-install pdo_mysql

# Enable mod_rewrite
RUN a2enmod rewrite

# Install composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/bin --filename=composer

# Add local code
ADD . /var/www/sleeti

WORKDIR /var/www/sleeti

# Override configuration with Docker-specific one
COPY ./config/config.docker.json ./config/config.json

RUN mkdir -p /var/www/sleeti/uploads \
    && chmod -R 777 /var/www/sleeti/uploads \
    && mkdir -p /var/www/sleeti/resources/views/cache/ \
    && chmod -R 777 /var/www/sleeti/resources/views/cache \
    && mkdir -p /var/www/sleeti/logs \
    && chmod -R 777 /var/www/sleeti/logs

# Install composer deps
RUN composer install
