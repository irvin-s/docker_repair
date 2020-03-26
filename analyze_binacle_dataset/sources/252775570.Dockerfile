FROM php:5.4-apache  
  
# install PHP extensions  
RUN docker-php-ext-install pdo pdo_mysql  

