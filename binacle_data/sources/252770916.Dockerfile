FROM node:alpine  
  
WORKDIR /app  
  
ADD package.json package-lock.json ./  
RUN npm install  
ADD . .  
  
CMD ["node", "src/index.js"]  
  

