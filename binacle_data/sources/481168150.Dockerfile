FROM php:7.1.20-fpm
RUN apt-get update && apt-get install -y \
       libpq-dev \ 
       libmcrypt-dev \
       libpng-dev \
       libjpeg62-turbo-dev \
       libfreetype6-dev \
       libxrender1 \
       libfontconfig \
       libxext-dev \
 && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
 && docker-php-ext-install -j$(nproc) pdo_mysql mysqli mcrypt gd zip
WORKDIR /usr/share/nginx/html/attendize
