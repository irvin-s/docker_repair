FROM php:7.0-cli  
  
RUN docker-php-ext-install bcmath  
  
VOLUME /var/www  
COPY . /var/www  
WORKDIR /var/www  
  
ENTRYPOINT ["php", "run.php"]  

