FROM php:5-fpm  
  
RUN apt-get update && apt-get install -y libmcrypt-dev  
RUN docker-php-ext-install mbstring mcrypt pdo pdo_mysql  
  
COPY php.ini /usr/local/etc/php/  
  
CMD ["php-fpm"]  

