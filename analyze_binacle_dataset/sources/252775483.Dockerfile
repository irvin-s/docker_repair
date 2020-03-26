FROM composer/composer:latest  
  
MAINTAINER Benjamin Bennett <bennett.d.ben@gmail.com>  
  
# Install packages required for installing mogodb  
RUN apt-get update && apt-get install -y \  
autoconf \  
g++ \  
make \  
openssl \  
libcurl4-openssl-dev \  
libssl-dev  
  
# Install and link MongoDB extension  
RUN pecl install mongodb  
RUN echo "extension=mongodb.so" > /usr/local/etc/php/conf.d/mongodb.ini  

