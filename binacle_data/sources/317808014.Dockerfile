FROM php:7-apache
ENV TZ=Asia/Shanghai
COPY ./sources.list /etc/apt/sources.list
COPY ./php.ini /usr/local/etc/php/
RUN apt update \
  && apt-get install -y libfreetype6-dev libjpeg62-turbo-dev libpng-dev libmcrypt-dev \
  && docker-php-ext-install pdo_mysql mysqli mbstring gd iconv 
