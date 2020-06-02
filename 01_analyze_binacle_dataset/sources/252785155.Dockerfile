FROM php:7.0-fpm  
  
COPY fpm/php.ini /usr/local/etc/php/  
RUN docker-php-ext-install bcmath  
  
WORKDIR /var/www/html  

