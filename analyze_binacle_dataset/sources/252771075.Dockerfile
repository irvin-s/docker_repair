# specify the node base image with your desired version node:<version>  
FROM node:carbon  
# Create app directory  
WORKDIR /home/ahmed/Desktop/Sooty.Chat  
# where available (npm@5+)  
COPY package*.json ./  
  
RUN npm install  
# If you are building your code for production  
COPY . .  
  
EXPOSE 3000  
CMD [ "npm", "start" ]  

