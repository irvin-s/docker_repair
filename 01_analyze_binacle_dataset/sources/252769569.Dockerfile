FROM node:9.11.1  
RUN mkdir /app  
WORKDIR /app  
  
COPY package.json /app/  
RUN npm install && npm cache clean --force  
COPY . /app  
  
CMD [ "npm", "start" ]  

