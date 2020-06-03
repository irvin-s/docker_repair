FROM node:alpine  
# Create app directory  
# Change to capital  
WORKDIR /usr/src/app  
  
COPY package*.json ./  
RUN npm install  
COPY . .  
  
#EXPOSE 8080  
CMD [ "npm", "start" ]

