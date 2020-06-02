FROM php:7.2.7-apache

COPY config/apache.conf /etc/apache2/sites-available/000-default.conf
COPY config/php.ini /usr/local/etc/php/

RUN docker-php-ext-install \
    pdo_mysql

COPY . /var/www/html/

RUN mkdir -p /tmp/boxmeup/persistent /tmp/boxmeup/models && \
    chmod -R 0777 /tmp/boxmeup && \
    chown -R www-data:www-data /tmp/boxmeup

RUN a2enmod rewrite

EXPOSE 80
