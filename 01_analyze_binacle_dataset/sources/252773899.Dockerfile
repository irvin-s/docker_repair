FROM php:7.1-apache  
LABEL Maintainer="Yann Ponzoni <alphayax@gmail.com>"  
  
RUN apt-get update \  
&& apt-get install -y \  
libmemcached-dev \  
zlib1g-dev \  
&& pecl install \  
memcached-3.0.3 \  
&& docker-php-ext-enable \  
memcached  
  
COPY . /var/www/html/  
  
RUN chown -R www-data: /var/www/html/  
  

