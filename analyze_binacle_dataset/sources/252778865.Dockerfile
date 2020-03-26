FROM php:5.6-alpine  
  
MAINTAINER Milan Sulc <sulcmil@gmail.com>  
  
RUN docker-php-ext-install pdo pdo_mysql  

