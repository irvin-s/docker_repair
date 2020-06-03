FROM php:5.5-apache  
  
COPY config/php.ini /usr/local/etc/php/  
COPY src/ /var/www/html/  
  
MAINTAINER Scott Eppler version: 0.1

