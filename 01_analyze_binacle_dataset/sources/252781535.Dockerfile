FROM node:8.9.4-alpine  
  
COPY package.json package.json  
RUN npm install  
  
COPY . .  
  
CMD ["node", "."]  

