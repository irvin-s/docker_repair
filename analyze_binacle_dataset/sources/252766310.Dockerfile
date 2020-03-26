FROM ubuntu:trusty  
MAINTAINER Abhishek Jaiswal <abhishekjaiswal.kol@gmail.com>  
  
# prevent dpkg errors  
ENV TERM=xterm-256color  
  
  
# Install node.js  
RUN apt-get update && \  
apt-get install curl -y && \  
curl -sL https://deb.nodesource.com/setup_4.x | sudo -E bash - && \  
apt-get install -y nodejs  
  
COPY . /app  
  
WORKDIR /app  
  
# install application dependencies  
RUN npm install -g mocha && \  
npm install  
  
# set mocha test runner entrypoint  
ENTRYPOINT ["mocha"]

