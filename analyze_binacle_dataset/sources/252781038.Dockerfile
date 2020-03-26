FROM php:7.1-fpm-alpine  
  
RUN apk add --no-cache \  
freetype-dev \  
icu-dev \  
libjpeg-turbo-dev \  
libmcrypt-dev \  
libpng-dev \  
libxslt-dev \  
&& apk add --virtual .buildep --no-cache \  
autoconf \  
g++ \  
make \  
&& docker-php-ext-configure \  
gd --with-freetype-dir=/usr/include/ \--with-jpeg-dir=/usr/include/ \  
&& docker-php-ext-install \  
bcmath \  
gd \  
intl \  
mbstring \  
mcrypt \  
opcache \  
pdo_mysql \  
soap \  
xsl \  
zip \  
&& pecl install redis \  
&& docker-php-ext-enable redis \  
&& apk del .buildep  
  
COPY conf.d/ /usr/local/etc/php/conf.d/  

