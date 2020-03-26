FROM php:5-fpm-alpine  
  
MAINTAINER Janaka Wickramasinghe <janaka@ascesnionit.com.au>  
  
RUN set -eux \  
&& apk add --no-cache --virtual .build-deps libmcrypt-dev libjpeg-turbo-dev \  
freetype-dev libpng-dev openldap-dev mariadb-dev \  
\  
&& docker-php-ext-configure gd --with-freetype-dir=/usr/include/ \  
\--with-jpeg-dir=/usr/include/ \  
\  
&& pecl install redis-3.1.2 \  
\  
&& docker-php-ext-install -j$(getconf _NPROCESSORS_ONLN) mcrypt gd ldap \  
opcache mysql pdo_mysql zip \  
\  
&& docker-php-ext-enable redis \  
\  
&& runDeps="$( \  
scanelf --needed --nobanner --recursive /usr/local \  
| awk '{ gsub(/,/, "\nso:", $2); print "so:" $2 }' \  
| sort -u \  
| xargs -r apk info --installed \  
| sort -u \  
)" \  
\  
&& apk add --virtual .php-rundeps $runDeps \  
\  
&& apk del .build-deps  

