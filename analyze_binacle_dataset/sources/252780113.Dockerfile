FROM jeanblanchard/java:serverjre-8u45  
  
MAINTAINER Scott Miller <scott.miller171@gmail.com>  
RUN apk add --update bash && rm -rf /var/cache/apk/*  

