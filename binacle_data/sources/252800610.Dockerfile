FROM node:6.8.0-slim  
  
RUN npm install -g yarn  
  
VOLUME /data  
WORKDIR /data  
  
EXPOSE 3000  

