FROM alpine:3.7 as git  
  
RUN apk --update add git  
WORKDIR /data  
RUN git clone https://github.com/coolder/belliga-api.git  
  
FROM composer as composer  
WORKDIR /data  
COPY \--from=git /data/belliga-api .  
RUN composer install  
  
FROM php:7.2-fpm-alpine3.7  
WORKDIR /var/www/belliga  
COPY \--from=composer /data .  
  
ADD belliga.pool.conf /etc/php7/php-fpm.d/  
  
CMD ["php-fpm"]  

