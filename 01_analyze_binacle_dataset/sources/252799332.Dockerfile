FROM dftlatam/docker-fpm-alpine-bob  
  
RUN set -xe \  
&& apk add --no-cache wget git \  
&& wget https://pecl.php.net/get/xdebug \  
&& tar -xf xdebug \  
&& mkdir -p /usr/src/php/ext \  
&& mv xdebug-* /usr/src/php/ext/xdebug \  
&& docker-php-ext-install xdebug \  
&& wget https://getcomposer.org/composer.phar \  
&& mv composer.phar /usr/local/bin/composer \  
&& chmod +x /usr/local/bin/composer \  
&& apk del wget \  
&& rm -fr /usr/src/php/ext  

