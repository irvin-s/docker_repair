FROM node:5.3  
  
RUN apt-get update && apt-get install -yqq graphicsmagick  
  
RUN npm install -g typescript

