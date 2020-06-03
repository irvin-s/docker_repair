FROM alpine  
MAINTAINER Brad Wadsworth  
  
ENV CERTSDIR /certs  
ENV SAN DNS:localhost  
  
RUN apk \--no-cache add openssl  
  
ADD openssl.cnf /etc/ssl/  
ADD create-certs.sh /  
RUN chmod +x /create-certs.sh  
ENTRYPOINT ["/create-certs.sh"]  

