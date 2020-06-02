FROM php:7.0-apache
RUN docker-php-ext-install pdo_mysql mysqli \
  && a2enmod rewrite \
 && sed -i 's!/var/www/html!/var/www/public!g' /etc/apache2/sites-available/000-default.conf \
 && mv /var/www/html /var/www/public

WORKDIR /var/www