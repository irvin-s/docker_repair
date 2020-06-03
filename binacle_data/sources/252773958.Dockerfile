FROM node:boron  
WORKDIR /opt/altcast-ticker  
  
COPY package.json .  
COPY package.json package-lock.json ./  
  
RUN npm install --production  
  
COPY . .  
  
CMD [ "npm", "start" ]  

