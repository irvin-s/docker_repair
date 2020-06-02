# Dockerfile for Swagger Editor  
# Updated 20150430  
FROM ubuntu:latest  
MAINTAINER Victor Hernandez <victor.hernandez@byteflair.com>  
  
# Update and install the required software  
RUN apt-get update  
RUN apt-get upgrade -y  
RUN apt-get dist-upgrade -y  
RUN apt-get autoremove -y  
RUN apt-get install -y git nodejs npm  
  
RUN ln -s /usr/bin/nodejs /usr/bin/node  
  
# Install Swagger editor  
RUN git clone https://github.com/swagger-api/swagger-editor.git swagger-editor  
  
WORKDIR swagger-editor  
RUN sed -i 's/localhost/0.0.0.0/g' grunt/connect.js  
RUN npm install  
  
# Expose ports  
EXPOSE 9000  
CMD cd /swagger-editor; npm start  

