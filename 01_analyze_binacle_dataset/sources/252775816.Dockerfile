FROM maven:alpine  
MAINTAINER bluebu <bluebuwang@gmail.com>  
  
#------------------------------------------------------------------------------  
# Environment variables:  
#------------------------------------------------------------------------------  
RUN \  
apk --update --upgrade add openssh nodejs git && \  
rm /var/cache/apk/*  

