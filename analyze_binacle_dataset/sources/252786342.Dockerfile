FROM php:7.2-fpm  
RUN docker-php-ext-install -j$(nproc) opcache  

