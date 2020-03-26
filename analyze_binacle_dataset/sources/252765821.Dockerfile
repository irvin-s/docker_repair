FROM php:7-apache  
  
RUN a2enmod rewrite  
  
# install the PHP extensions we need  
RUN docker-php-ext-install mbstring pdo pdo_mysql

