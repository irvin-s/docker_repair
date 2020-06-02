FROM php:7.0-apache  
COPY . /var/www/html/  
RUN a2enmod rewrite  

