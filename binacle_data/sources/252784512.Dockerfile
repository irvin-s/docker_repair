FROM busybox  
  
MAINTAINER Björn Heneka <bheneka@codebee.de>  
  
RUN mkdir -p /var/www/symfony/data  
VOLUME /var/www/symfony/data  

