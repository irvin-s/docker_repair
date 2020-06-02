FROM php:7-apache  
MAINTAINER Colin O'Dell <colinodell@gmail.com>  
  
WORKDIR /var/www  
  
COPY . .  
  
RUN set -ex \  
&& docker-php-ext-install opcache \  
&& rm -rf /var/www/html \  
&& mv web html \  
&& apt-get update \  
&& apt-get install -y git \  
&& curl -sS https://getcomposer.org/installer | php \  
&& ./composer.phar install -o --no-progress --no-suggest --no-dev \  
&& rm composer.phar \  
&& apt-get purge -y --auto-remove git \  
&& rm -rf /var/lib/apt/lists/*  

