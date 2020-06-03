FROM alpine:3.4  
  
ENV VERSION 0.7.0  
  
RUN apk --no-cache add \  
certbot==$VERSION-r0  

