FROM alpine  
MAINTAINER Athurg Gooth <athurg@gooth.org>  
  
RUN apk --update add git openssh && \  
rm -rf /var/lib/apt/lists/* && \  
rm /var/cache/apk/*  

