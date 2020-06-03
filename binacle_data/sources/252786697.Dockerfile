FROM php:5.6-fpm  
  
MAINTAINER Jérémy Leherpeur <jeremy@leherpeur.net>  
  
# Install Composer  
RUN curl -sS https://getcomposer.org/installer | php  
RUN mv composer.phar /usr/local/bin/composer  
  
RUN mkdir /var/www/app  
VOLUME ["/var/www/app"]  
  
WORKDIR /var/www/app  

