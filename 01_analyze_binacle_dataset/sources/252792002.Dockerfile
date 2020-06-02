FROM php:7.1.4-alpine  
  
LABEL maintainer "chaoticsound@outlook.com"  
LABEL version "1.0.0"  
  
ENV phinx_command migrate  
  
RUN apk update  
RUN apk add curl  
RUN docker-php-ext-install pdo pdo_mysql  
COPY composer.json /home  
WORKDIR /home  
RUN curl -s https://getcomposer.org/installer | php  
RUN php composer.phar install  
WORKDIR /phinx  
  
CMD php /home/vendor/bin/phinx $phinx_command

