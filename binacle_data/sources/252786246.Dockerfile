FROM php:5.6-apache  
  
RUN a2enmod rewrite proxy proxy_http  
  
COPY image-files/apache /

