FROM node:alpine  
  
WORKDIR /src  
COPY . /src  
  
RUN npm i --only=production  
  
CMD ["npm", "start"]

