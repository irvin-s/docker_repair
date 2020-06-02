FROM busybox:latest  
MAINTAINER Chris Hocker <chocker@cisco.com>  
RUN mkdir -p /var/lib/mysql && mkdir -p /var/www/html  
VOLUME ["/var/lib/mysql", "/var/www/html"]  

