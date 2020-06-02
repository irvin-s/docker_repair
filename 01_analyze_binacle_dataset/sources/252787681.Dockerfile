FROM php:5.6-cli  
MAINTAINER Bruno Moyle <brunitto@gmail.com>  
RUN apt-get update -y && apt-get install -y libicu-dev \  
&& docker-php-ext-install intl  
COPY . /usr/src/cakephp  
WORKDIR /usr/src/cakephp  
EXPOSE 8765  
CMD bin/cake server -H 0.0.0.0  
  

