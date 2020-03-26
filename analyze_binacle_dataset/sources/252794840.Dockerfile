FROM node:alpine  
  
WORKDIR /src  
  
COPY . /src  
  
RUN npm install --only=production  
  
EXPOSE 3000  
CMD ["npm", "start"]  

