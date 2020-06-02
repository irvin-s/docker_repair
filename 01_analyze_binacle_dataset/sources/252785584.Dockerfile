FROM comicrelief/php-base:7.1  
COPY vhost/* /etc/apache2/sites-available/  
  
RUN a2ensite web ssl ; apt-get update \  
; apt-get install -y --fix-missing libxml2-dev  
  
RUN curl -sL https://deb.nodesource.com/setup_8.x | bash - \  
; apt-get install -y nodejs ; npm install -g grunt-cli yarn  

