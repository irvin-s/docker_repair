# VERSION: 0.0.1  
FROM ubuntu:14.10  
MAINTAINER Daniel Beck "d.danielbeck@googlemail.com"  
# Environment variables  
ENV DEBIAN_FRONTEND noninteractive  
ENV CORDOVA_VERSION 4.2.0  
RUN apt-get update  
RUN apt-get install -y nodejs npm libncurses5 lib32stdc++6 lib32z1  
  
RUN rm -rf /var/lib/apt/lists/*  
RUN apt-get autoremove -y  
RUN apt-get clean  
  
# install cordova  
RUN ln -s /usr/bin/nodejs /usr/bin/node  
RUN npm install -g cordova@5.0.0 shelljs  
  

