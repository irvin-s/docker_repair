FROM cheeryfella/php-fpm  
  
RUN pecl install mongodb  
  
WORKDIR /var/www/html  
  
EXPOSE 9000  

