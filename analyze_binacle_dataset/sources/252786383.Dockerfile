FROM alpine:latest  
MAINTAINER Jacques Moati <jacques@moati.net>  
  
RUN apk --update add bash shadow openssl && \  
  
rm -rf /var/cache/apk/*  

