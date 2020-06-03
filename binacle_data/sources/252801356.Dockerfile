FROM tetraweb/php:7.1  
# Update and Install Packages  
RUN apt-get update -y && apt-get install -y \  
unzip \  
libfontconfig \  
libicu-dev \  
libzip-dev \  
jq  
  
RUN docker-php-ext-install intl zip  
  
# Update Node.js  
RUN curl -sL https://deb.nodesource.com/setup_8.x | bash - \  
&& apt-get install -y nodejs build-essential  
  
RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"  
RUN php composer-setup.php  
RUN php -r "unlink('composer-setup.php');"  

