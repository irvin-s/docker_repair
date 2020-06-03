FROM node:9.11.1-alpine  
ADD ./src /app  
WORKDIR /app  
RUN npm install  
CMD ["node", "index.js", "/config/mediaclerk.json"]  

