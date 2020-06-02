FROM php:7.1.16-fpm  
  
MAINTAINER Adam Jarvis <adam.d.jarvis@ibm.com>  
  
# Common  
RUN apt-get update \  
&& apt-get install -y \  
mysql-client -y  
  
# PHP  
# Add extensions  
RUN docker-php-ext-install \  
pdo_mysql  
  
WORKDIR /srv/www  

