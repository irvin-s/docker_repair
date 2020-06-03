FROM node:slim  
  
# Create app directory  
WORKDIR /usr/src/app  
  
COPY package*.json ./  
  
# Install dependencies  
RUN npm install  
  
COPY . .  
  
EXPOSE 3000  
CMD [ "npm", "start" ]  

