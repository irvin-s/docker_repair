FROM php:5.4-apache 

COPY src/ /var/www/html/
RUN chown -R www-data:www-data /var/www/html/ 
