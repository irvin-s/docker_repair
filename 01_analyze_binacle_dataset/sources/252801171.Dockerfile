FROM hermsi/alpine-fpm-php  
  
COPY ./ /var/www/test-request-keeper  
  
WORKDIR /var/www/test-request-keeper  
  
RUN curl -sS https://getcomposer.org/installer | php \  
&& mv composer.phar /usr/local/bin/composer \  
&& composer install --prefer-dist  
  

