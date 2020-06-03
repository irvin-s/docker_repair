FROM php:7-fpm  
  
RUN usermod -u 1000 www-data  
RUN usermod -G staff www-data  
  
RUN apt-get update -y && \  
apt-get install -y \  
libmcrypt-dev \  
sqlite \  
libsqlite3-0 \  
libsqlite3-dev \  
openssl  
  
RUN docker-php-ext-install mbstring pdo_mysql pdo_sqlite mcrypt  
  
COPY php.ini /usr/local/etc/php/  

