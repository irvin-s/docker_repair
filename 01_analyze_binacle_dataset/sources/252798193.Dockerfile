FROM rtancman/php:php53-apache22  
  
RUN apt-get update && apt-get install -y aptitude git zlib1g-dev  
RUN aptitude install -y -f phpunit  
  
RUN curl -s https://getcomposer.org/installer | php  
RUN mv composer.phar /usr/local/bin/composer  

