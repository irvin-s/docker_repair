############################################################  
# Dockerfile to build java 8 container images  
# Based on phusion/baseimage  
############################################################  
# Set the base image to phusion/baseimage  
#FROM phusion/baseimage:latest  
#CMD ["/sbin/my_init"]  
  
FROM ubuntu  
  
LABEL maintainer "Jonathan Temlett - Daedalus Solutions (jono@daedalus.co.za)"  
  
#ARG VCS_REF  
#LABEL org.label-schema.vcs-ref=$VCS_REF \  
# org.label-schema.vcs-url="https://bitbucket.org/temdu/env-java"  
  
RUN apt-get update  
RUN apt-get install -y curl  
RUN curl -sL https://deb.nodesource.com/setup_6.x | bash -  
RUN apt-get install -y nodejs && \  
apt-get install -y git && \  
apt-get install -y build-essential  
  
RUN npm install -g @angular/cli@1.3.1  

