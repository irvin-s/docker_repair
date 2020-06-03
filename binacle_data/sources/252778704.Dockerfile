FROM node:6.11  
WORKDIR /app  
  
COPY . .  
  
RUN npm install  
  
CMD node index.js  

