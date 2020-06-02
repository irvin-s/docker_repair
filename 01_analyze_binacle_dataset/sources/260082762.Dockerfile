FROM php:5.6-apache
RUN apt-get update && apt-get install -y libpq-dev && docker-php-ext-install pgsql
COPY *.php /var/www/html/
