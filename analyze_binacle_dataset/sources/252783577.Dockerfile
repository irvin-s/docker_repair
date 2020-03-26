FROM node:8.1.4-alpine  
COPY ./ /usr/local/src/  
WORKDIR /usr/local/src/  
  
RUN npm install --only=production  
  
CMD ["npm", "start"]  

