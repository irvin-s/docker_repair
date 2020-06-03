FROM node:9.2.0-slim  
  
COPY index.js /app/index.js  
  
COPY package.json /package.json  
  
RUN npm install  
  
WORKDIR /app  
  
EXPOSE 8080  
CMD node index.js

