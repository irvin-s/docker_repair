FROM node:6  
RUN apt-get update  
RUN npm install -g ask-cli  
WORKDIR /opt/app

