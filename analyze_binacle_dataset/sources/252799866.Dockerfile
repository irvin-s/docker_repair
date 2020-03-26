FROM node:8  
RUN apt update && apt install -y python-pip python-dev && pip install awscli  
RUN npm install -g cordova ionic  
  

