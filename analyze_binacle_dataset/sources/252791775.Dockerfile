FROM node:boron  
  
RUN mkdir /app  
WORKDIR /app  
  
COPY package.json /app  
RUN npm install  
RUN npm install nodemon eslint -g  
  
COPY . /app  
  
EXPOSE 3000

