FROM ubuntu:16.04  
MAINTAINER cm0x4d <cm0x4d@codemonkey.ch>  
  
RUN apt-get update && apt-get install -y curl  
RUN curl -sL https://deb.nodesource.com/setup_6.x | bash -  
RUN apt-get install -y nodejs  
RUN npm install jsdoc -g

