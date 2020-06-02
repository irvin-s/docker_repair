FROM wordpress:php7.1  
  
RUN apt-get update && apt-get install -y libxml2 libxml2-dev  
  
# Install PHP Soap Extention  
RUN docker-php-ext-install soap  

