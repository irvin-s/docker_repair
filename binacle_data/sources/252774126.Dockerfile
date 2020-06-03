FROM php:5.6-apache  
  
RUN docker-php-ext-install pdo mysql  
RUN docker-php-ext-install pdo mysqli  
  
COPY src/ /var/www/html/  
  
RUN chown -R www-data:www-data /var/www/html/

