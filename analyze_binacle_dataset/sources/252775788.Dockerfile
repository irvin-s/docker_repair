# ownCloud image. The ownCloud files are supposed to be self managed in this  
# image.  
  
FROM blowb/php:5.6-apache  
  
MAINTAINER Hong Xu <hong@topbug.net>  
  
RUN apt-get update && apt-get install -y --no-install-recommends \  
bzip2 \  
g++ \  
libav-tools \  
libbz2-dev \  
libcurl4-openssl-dev \  
libfreetype6-dev \  
libicu-dev \  
libldap2-dev \  
libmagic-dev \  
libmagickwand-dev \  
libmcrypt-dev \  
libpng-dev \  
libreoffice-common  
  
RUN docker-php-ext-configure gd --with-freetype-dir=/usr/include  
RUN docker-php-ext-configure ldap --with-libdir=lib/x86_64-linux-gnu  
RUN docker-php-ext-install \  
bz2 \  
ctype \  
dom \  
exif \  
fileinfo \  
gd \  
iconv \  
intl \  
json \  
ldap \  
mbstring \  
mcrypt \  
mysql \  
opcache \  
pdo \  
pdo_mysql \  
simplexml \  
xmlwriter \  
zip  
  
COPY install.sh /usr/local/bin/install.sh  

