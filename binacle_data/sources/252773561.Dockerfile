FROM ubuntu:trusty  
MAINTAINER Aliaksei Kiryanau <aliaksei.kiryanau1@gmail.com>  
  
# Prevent dpkg errors  
ENV TERM=xterm-256color  
  
# Set morrors to BY  
RUN sed -i "s/http:\/\/archive./http:\/\/by.archive./g" /etc/apt/sources.list  
  
# Install node.js  
RUN apt-get update && \  
apt-get install curl -y && \  
curl -sL https://deb.nodesource.com/setup_4.x | sudo -E bash - && \  
apt-get install -y nodejs  
  
COPY . /app  
WORKDIR /app  
  
# Install application dependencies  
RUN npm install -g mocha && \  
npm install  
  
# Set mocha test runner as entrypoint  
ENTRYPOINT ["mocha"]

