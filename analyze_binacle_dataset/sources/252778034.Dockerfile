FROM php:5.6-fpm  
  
MAINTAINER Andrey Portnov <aportnov@gmail.com>  
  
RUN apt-get update && apt-get install -y \  
libmcrypt-dev \  
libpng12-dev \  
libxml2-dev \  
&& docker-php-ext-install \  
mcrypt \  
gd \  
soap \  
mbstring\  
pdo_mysql  
  
  
EXPOSE 9000  

