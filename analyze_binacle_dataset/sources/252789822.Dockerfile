FROM node:8-alpine  
  
RUN mkdir /app  
WORKDIR /app  
  
ADD package-lock.json ./  
ADD package.json ./  
  
RUN npm install cross-env  
RUN npm install -g  

