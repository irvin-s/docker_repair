FROM comicrelief/php-base:7.1  
RUN a2ensite web web-ssl ; apt-get update ; \  
apt-get install -y --fix-missing libxml2-dev  
  
RUN docker-php-ext-install soap  
  
RUN curl -sL https://deb.nodesource.com/setup_8.x | bash - \  
; apt-get install -y nodejs ; npm install -g grunt-cli yarn  

