FROM node:0.10  
  
  
EXPOSE 3000  
  
WORKDIR /app  
CMD npm install && node app.js  

