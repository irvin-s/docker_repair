FROM node:8  
# Create app directory  
WORKDIR /usr/src/app  
  
# Install app dependencies  
COPY package.json package-lock.json ./  
RUN npm install  
  
# Bundle app source  
COPY . .  
  
EXPOSE 3000  
CMD [ "npm", "start" ]  

