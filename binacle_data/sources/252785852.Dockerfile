FROM node:alpine  
  
WORKDIR /usr/src/app  
ADD ./app/package.json ./  
RUN npm install  
ADD ./app/ ./  
  
EXPOSE 80  
CMD ["node", "index.js"]

