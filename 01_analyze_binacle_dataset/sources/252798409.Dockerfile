FROM php:5.6.2-cli  
MAINTAINER Denis Uraganov <github@uraganov.net>  
  
RUN curl -O https://phar.phpunit.de/phploc.phar  
RUN mv phploc.phar /usr/local/bin/phploc  
RUN chmod +x /usr/local/bin/phploc  
  
RUN mkdir -p /workspace  
WORKDIR /workspace  
  
ENTRYPOINT ["phploc"]

