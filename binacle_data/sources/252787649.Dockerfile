FROM php:7.1-apache  
COPY ./ /var/www/html/  
RUN chmod 777 /var/www/html/cache

