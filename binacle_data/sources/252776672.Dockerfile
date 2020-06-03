############################################################  
# Dockerfile to build a java base image for containers  
# Based on Alpine  
############################################################  
  
FROM alpine:3.3  
MAINTAINER cavemandaveman <cavemandaveman@openmailbox.org>  
  
RUN apk --update add openjdk8-jre-base  

