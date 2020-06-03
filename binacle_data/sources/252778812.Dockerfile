FROM node:6.3-slim  
  
RUN npm install -g gulp serverless@0.5.6  
  
WORKDIR /app  

