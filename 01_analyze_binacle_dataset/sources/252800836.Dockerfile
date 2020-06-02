FROM dotronglong/php:cli  
  
RUN pecl install xdebug \  
&& docker-php-ext-enable xdebug  

