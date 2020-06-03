FROM node:7.1.0  
# Create app directory  
WORKDIR /app  
  
# Install app dependencies  
COPY package.json /app/  
RUN npm install  

