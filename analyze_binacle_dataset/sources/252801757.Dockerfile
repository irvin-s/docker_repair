FROM alpine:3.3  
MAINTAINER Corey Butler  
  
RUN apk add --update curl openssl ca-certificates bash \  
&& rm -rf /var/cache/apk/*  

