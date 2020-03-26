FROM php:7-fpm  
MAINTAINER Alexis Vincent <alexis@alexisvincent.io>  
  
# Install modules  
RUN docker-php-ext-install mbstring pdo pdo_mysql  
  
CMD ["php-fpm"]  
WORKDIR /var/www/  

