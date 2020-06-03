FROM node:carbon  
  
WORKDIR /gradissue-2017  
  
COPY package*.json .  
  
RUN npm install  
  
COPY . .  

