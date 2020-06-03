FROM alpine:latest  
  
RUN apk add --update curl \  
nmap \  
openssl \  
apache2-utils \  
&& rm -rf /var/cache/apk/*

