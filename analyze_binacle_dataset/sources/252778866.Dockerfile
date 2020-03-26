FROM php:7.0-alpine  
  
MAINTAINER Milan Sulc <sulcmil@gmail.com>  
  
RUN docker-php-ext-install pdo pdo_mysql  

