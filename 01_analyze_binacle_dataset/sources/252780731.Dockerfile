FROM alpine:3.1  
MAINTAINER Bruno Adelé "bruno@adele.im"  
  
# Install python 2.7 and other components  
RUN apk add \--update python python-dev py-pip curl && rm -rf /var/cache/apk/*  

