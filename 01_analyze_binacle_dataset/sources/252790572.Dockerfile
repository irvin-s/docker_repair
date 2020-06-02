# PHP-FPM 7 with opcache, bcmath and intl extensions  
FROM php:fpm  
MAINTAINER Carlos Buenosvinos <carlos.buenosvinos@gmail.com>  
  
RUN apt-get update && apt-get install -y \  
zlib1g-dev \  
libicu-dev \  
g++ \  
&& docker-php-ext-install -j$(nproc) bcmath opcache \  
&& docker-php-ext-configure intl \  
&& docker-php-ext-install -j$(nproc) intl  
  
RUN mkdir -p /usr/src/app  
  
VOLUME ["/usr/src/app"]

