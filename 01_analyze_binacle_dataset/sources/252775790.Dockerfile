# Piwik image. The piwik files are supposed to be self managed in this image.  
FROM blowb/php:5.6-fpm  
  
MAINTAINER Hong Xu <hong@topbug.net>  
  
RUN apt-get update && apt-get install -y --no-install-recommends \  
libcurl4-openssl-dev \  
libfreetype6-dev \  
libgeoip-dev \  
libldap2-dev \  
libpng-dev  
  
RUN docker-php-ext-configure gd --with-freetype-dir=/usr/include  
RUN docker-php-ext-configure ldap --with-libdir=lib/x86_64-linux-gnu  
RUN docker-php-ext-install \  
curl \  
gd \  
iconv \  
json \  
ldap \  
mbstring \  
opcache \  
pdo \  
pdo_mysql  
  
RUN pecl install geoip && \  
echo "extension=geoip.so" > /usr/local/etc/php/conf.d/geoip.ini  
  
COPY piwik.ini /usr/local/etc/php/conf.d/piwik.ini  
  
RUN mkdir -p /var/www/piwik  
  
WORKDIR /var/www/piwik  
  
COPY install.sh /usr/local/bin/install.sh  

