FROM php:5.6-cli  
MAINTAINER aehata  
  
ENV DEBIAN_FRONTEND noninteractive  
  
RUN apt-get update  
RUN docker-php-ext-install mbstring  
  

