FROM alpine:latest  
  
LABEL maintainer alexcastanodev@gmail.com  
  
RUN apk --update add git openssh && \  
rm -rf /var/lib/apt/lists/* && \  
rm /var/cache/apk/*  

