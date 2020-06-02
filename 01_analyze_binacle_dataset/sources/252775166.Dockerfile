FROM webdevops/php:alpine-php7  
  
RUN set -x \  
# Install php environment  
&& apk-install \  
php7-imagick  

