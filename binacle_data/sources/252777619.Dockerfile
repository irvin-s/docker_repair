FROM node:alpine  
MAINTAINER Anthony Rawlins <anthony.rawlins@unimelb.edu.au>  
  
# Make working dir  
WORKDIR /usr/src/app  
  
COPY package.json .  
COPY package-lock.json .  
  
RUN npm install  
  
COPY . .  
  
# Production  
# EXPOSE 4200  
# CMD ["npm", "start"]  
# Deployment  
EXPOSE 3000  
CMD ["node", "app.js"]  

