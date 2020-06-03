FROM php:7.0-apache  
RUN apt-get update  
RUN a2enmod rewrite  
COPY src/ /var/www/html/  
  

