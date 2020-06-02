FROM node:alpine  
  
WORKDIR /src  
COPY package.json ./  
RUN npm install  
COPY ./ ./  
  
EXPOSE 3000  
CMD ["node", "./app"]  

