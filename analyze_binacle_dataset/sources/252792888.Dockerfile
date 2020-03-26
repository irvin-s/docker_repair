FROM node:9.2-slim  
  
WORKDIR /usr/src/app  
  
COPY package*.json ./  
RUN npm install --only=production  
COPY . .  
EXPOSE 80  
CMD [ "npm", "start" ]  

