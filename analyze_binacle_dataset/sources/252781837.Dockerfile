FROM node:slim  
  
WORKDIR /app  
  
COPY package.json ./  
RUN npm install  
  
COPY . ./  
  
ENV NODE_ENV=production  
  
VOLUME /app/config.json  
  
EXPOSE 3000  
ENTRYPOINT node index.js config.json  

