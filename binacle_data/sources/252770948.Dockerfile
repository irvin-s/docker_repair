FROM busybox:latest  
MAINTAINER Alberto Gonzalez <algonzal@uji.es>  
RUN mkdir -p /var/lib/mysql && mkdir -p /var/www/html  
VOLUME ["/var/lib/mysql", "/var/www/html"]  

