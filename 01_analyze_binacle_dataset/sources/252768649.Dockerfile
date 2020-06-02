FROM busybox:latest  
MAINTAINER Anas mokhtari <anas.mokhtari@gmail.com>  
  
RUN mkdir -p /var/lib/mysql && mkdir -p /var/www/html  
VOLUME ["/var/lib/mysql", "/var/www/html"]  
  
  
  

