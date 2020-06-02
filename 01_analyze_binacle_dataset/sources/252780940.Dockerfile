FROM php:5  
RUN apt-get update && \  
apt-get install -y git rsync  
  
RUN curl -sS https://getcomposer.org/installer | php && \  
mv composer.phar /usr/local/bin/composer  
  
RUN apt-get install -y libpng12-dev && \  
docker-php-ext-install gd mbstring  

