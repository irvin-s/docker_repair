FROM node:alpine  
  
WORKDIR /usr/app  
  
COPY package.json package-lock.json ./  
RUN npm install --quiet  
  
COPY . .  
  
EXPOSE 4201/tcp  
  
CMD ["node","server.js"]  

