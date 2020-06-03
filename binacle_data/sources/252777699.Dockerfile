FROM php:7-fpm-alpine  
RUN apk add --no-cache \  
freetype-dev \  
libjpeg-turbo-dev \  
libpng-dev \  
bind-tools \  
&& docker-php-ext-install -j4 mysqli gd mbstring opcache  
COPY php/docker-forum-php-entrypoint /usr/local/bin/  
COPY php/php.ini /usr/local/etc/php/  
ENTRYPOINT ["docker-forum-php-entrypoint"]  
CMD ["php-fpm"]  
COPY forum/ /forum/  

