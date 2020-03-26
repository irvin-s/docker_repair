FROM php:5.6.2-cli  
MAINTAINER Denis Uraganov <github@uraganov.net>  
  
RUN apt-get update && apt-get install -y libbz2-dev  
RUN docker-php-ext-install bz2  
  
RUN curl -O http://static.phpmd.org/php/2.1.3/phpmd.phar  
RUN mv phpmd.phar /usr/local/bin/phpmd  
RUN chmod +x /usr/local/bin/phpmd  
  
RUN mkdir -p /workspace  
WORKDIR /workspace  
  
ENTRYPOINT ["phpmd"]

