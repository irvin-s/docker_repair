FROM ubuntu:trusty  
MAINTAINER David Paccoud <dpaccoud@gmail.com>  
  
# Prevent dpkg errors  
ENV TERM=xterm-256color  
  
# Set mirrors to FR  
RUN sed -i "s@http://archive.@http://fr.archive.@g" /etc/apt/sources.list  
  
# Install node.js  
RUN apt-get update && \  
apt-get install -qy curl && \  
curl -sL https://deb.nodesource.com/setup_4.x | sudo -E bash - && \  
apt-get install -y nodejs  
  
COPY . /app  
WORKDIR /app  
  
# Install application dependencies  
RUN npm install -g mocha && \  
npm install  
  
# Set mocha test runner as entrypoint  
ENTRYPOINT ["mocha"]  

