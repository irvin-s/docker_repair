FROM bbpdev/symfony:php7.0  
COPY resources/xdebug.ini /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini  
RUN docker-php-ext-enable xdebug  

