FROM node:9-alpine  
  
RUN mkdir -p /usr/src/app  
WORKDIR /usr/src/app  
  
COPY package.json /usr/src/app/  
RUN npm install --production && npm cache clean --force  
COPY . /usr/src/app  
EXPOSE 3000  
CMD [ "npm", "start" ]  

