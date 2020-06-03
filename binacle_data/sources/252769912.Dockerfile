############################################################  
# Dockerfile to build Golang with glide support  
# Based on golang:1.9  
#  
############################################################  
FROM golang:1.9  
  
MAINTAINER John Arroyo, john@arroyolabs.com  
  
# Linux updates  
RUN apt-get update  
  
# Add some go development packages (e.g. glide)  
ADD ./scripts /scripts  
RUN cd /scripts && chmod 770 *.sh && ./setup.sh  
  
# ARG PROJECT_NAME  
# ADD ./src/$PROJECT_NAME /go/src/$PROJECT_NAME  
# RUN cd /go/src && go install $PROJECT_NAME  
  
EXPOSE 8080  

