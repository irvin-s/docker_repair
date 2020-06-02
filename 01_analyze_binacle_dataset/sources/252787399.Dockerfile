FROM ubuntu:14.04  
MAINTAINER Aleh Humbar <og@gsl.tv>  
RUN mkdir -p /var/www/html  
COPY . /var/www/html  
VOLUME /var/www/html  
ENTRYPOINT /usr/bin/tail -f /dev/null  
  

