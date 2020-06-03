FROM php:5.6-fpm-alpine  
MAINTAINER pao0111@gmail.com  
  
RUN apk update \  
&& apk add \--no-cache $PHPIZE_DEPS \  
&& pecl install xdebug \  
&& docker-php-ext-enable xdebug  
  

