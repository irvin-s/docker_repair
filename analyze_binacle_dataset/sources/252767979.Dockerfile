FROM alpine:3.5  
MAINTAINER Adam Dodman <adam.dodman@gmx.com>  
  
RUN apk add --no-cache certbot  
  
ENTRYPOINT ["/usr/bin/certbot"]  

