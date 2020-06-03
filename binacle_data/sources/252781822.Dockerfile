FROM php:7.0-apache  
COPY config/php.ini /usr/local/etc/php/  
COPY src/ /var/www/html/  
LABEL "Dockerfile"="github.com/chrisbsmith/simple-php/Dockerfile"  
LABEL version="1.0"  

