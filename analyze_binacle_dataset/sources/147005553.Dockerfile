FROM php:7.2-apache

WORKDIR /var/www/html 
COPY index.php .
COPY flag.php /

EXPOSE 80
