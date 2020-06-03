FROM php:7-fpm-alpine  
# pdo_mysql mysqli mbstring iconv mcrypt  
RUN docker-php-ext-install pdo_mysql mysqli mbstring iconv mcrypt  

