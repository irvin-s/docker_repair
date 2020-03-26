FROM ubuntu:artful  
  
COPY docker-php-entrypoint /usr/bin/docker-php-entrypoint  
  
RUN apt-get update \  
&& apt-get install -y \  
php \  
php-mongodb \  
php-curl \  
php-xml \  
php-zip \  
php-mbstring \  
php-fpm \  
zip  
  
COPY php-fpm.d/php-fpm.conf /etc/php/7.1/fpm/php-fpm.conf  
COPY php-fpm.d/docker.conf /etc/php/7.1/fpm/docker.conf  
COPY php-fpm.d/zz-docker.conf /etc/php/7.1/fpm/zz-docker.conf  
  
ENTRYPOINT ["docker-php-entrypoint"]  
WORKDIR /var/www/html  
EXPOSE 9000  
CMD ["php-fpm7.1"]  

