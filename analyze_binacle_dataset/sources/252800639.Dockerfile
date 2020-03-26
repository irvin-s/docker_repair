FROM php:5.6  
  
MAINTAINER Donny Kurnia <donnykurnia@gmail.com>  
  
# Install modules  
RUN apt-get update -q && \  
DEBIAN_FRONTEND=noninteractive apt-get install -y apt-utils &&\  
DEBIAN_FRONTEND=noninteractive apt-get install -y \  
libmcrypt-dev firebird2.5-dev \  
libfreetype6-dev libjpeg62-turbo-dev libpng12-dev \  
libbz2-dev libssl-dev libicu-dev libzip-dev \  
libmagickwand-dev && \  
docker-php-ext-install bcmath calendar exif gettext mbstring \  
mcrypt pdo_firebird \  
gd \  
bz2 ftp intl zip && \  
pecl install imagick && \  
docker-php-ext-enable imagick && \  
apt-get clean && \  
rm -rf /var/lib/apt/lists/*  
  

