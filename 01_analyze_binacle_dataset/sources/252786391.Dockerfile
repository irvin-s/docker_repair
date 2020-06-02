FROM dockenizer/php7-fpm  
MAINTAINER Jacques Moati <jacques@moati.net>  
  
RUN apk --update add make g++ autoconf && \  
pecl install xdebug && \  
docker-php-ext-enable xdebug && \  
  
apk del --purge make g++ autoconf libtool && \  
rm -rf /var/cache/apk/*  

