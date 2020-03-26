FROM node:9-alpine  
  
COPY package.json package-lock.json index.js /app/  
  
WORKDIR /app  
RUN npm i  
  
CMD node index.js

