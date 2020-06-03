# Dockerfile for RAML API Designter  
# Updated 20150430  
FROM ubuntu:latest  
MAINTAINER Byteflair <hola@byteflair.com>  
  
# Update and install the required software  
RUN apt-get update  
RUN apt-get upgrade -y  
RUN apt-get dist-upgrade -y  
RUN apt-get autoremove -y  
RUN apt-get install -y git nodejs npm  
  
RUN ln -s /usr/bin/nodejs /usr/bin/node  
  
# Install RAML editor  
RUN git clone https://github.com/mulesoft/api-designer.git raml-editor  
  
WORKDIR /raml-editor  
RUN sed -i 's/localhost/0.0.0.0/g' Gruntfile.js  
RUN npm install -g grunt-cli  
RUN npm install -g bower  
RUN npm install  
RUN bower install --allow-root  
  
# Expose ports  
EXPOSE 9013  
CMD cd /raml-editor; grunt server -f  

