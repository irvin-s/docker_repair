# Base Image  
FROM python:2-onbuild  
MAINTAINER Chris Haid <chaid@kippchicago.org>  
  
RUN apt-get update  
RUN apt-get install -y vim  
  
# WORKDIR /code

