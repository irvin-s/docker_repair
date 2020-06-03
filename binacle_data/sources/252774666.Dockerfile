FROM ubuntu:latest  
MAINTAINER Matt Brewster <matt.brewster@base2s.com>  
  
RUN apt-get update && apt-get -y install nodejs npm  
RUN ln -s /usr/bin/nodejs /usr/bin/node  
RUN npm install -g frisby jasmine-node  

