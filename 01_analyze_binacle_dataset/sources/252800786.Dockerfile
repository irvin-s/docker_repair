FROM node:alpine  
  
WORKDIR /src  
  
COPY package.json /src  
RUN npm i --only=production  
  
COPY . /src  
  
CMD ["npm", "start"]

