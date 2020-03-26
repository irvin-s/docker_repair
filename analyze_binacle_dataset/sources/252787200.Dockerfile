FROM alpine  
MAINTAINER Paul Nicholson <brenix@gmail.com>  
  
RUN apk add --update bash git openssh-client && \  
rm /var/cache/apk/*  

