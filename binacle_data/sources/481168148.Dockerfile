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

RUN apt-get install -y zip unzip curl git
RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
RUN php composer-setup.php --install-dir=/usr/bin --filename=composer
RUN php -r "unlink('composer-setup.php');"
WORKDIR /usr/share/nginx/html/attendize