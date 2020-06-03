FROM php:5.6.2-cli  
MAINTAINER Denis Uraganov <github@uraganov.net>  
  
RUN curl -O https://phar.phpunit.de/phpunit.phar  
RUN mv phpunit.phar /usr/local/bin/phpunit  
RUN chmod +x /usr/local/bin/phpunit  
  
RUN mkdir -p /workspace  
WORKDIR /workspace  
  
ENTRYPOINT ["phpunit"]

