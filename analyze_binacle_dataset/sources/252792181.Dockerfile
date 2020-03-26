FROM node:8.1-alpine  
WORKDIR /app  
  
COPY package.json /app  
RUN yarn install  
  
COPY . /app  
EXPOSE 80  
CMD npm start  
  
LABEL name=docker-hub-rss version=dev \  
maintainer="Simone Esposito <chaufnet@gmail.com>"  

