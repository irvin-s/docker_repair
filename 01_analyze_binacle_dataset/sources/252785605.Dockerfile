FROM comicrelief/php-base:7.1  
RUN a2ensite symfony ; apt-get update ; \  
apt-get install -y --fix-missing libxml2-dev  
RUN docker-php-ext-install soap  
  
# Install APCU  
RUN pecl install apcu-5.1.8 \  
&& docker-php-ext-enable apcu  
  

