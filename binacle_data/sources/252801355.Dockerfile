FROM tetraweb/php:5.6  
# Update and Install Packages  
RUN apt-get update -y && apt-get install -y \  
zlib1g-dev  
  
RUN docker-php-ext-install zip  
  
RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"  
RUN php composer-setup.php  
RUN php -r "unlink('composer-setup.php');"  

