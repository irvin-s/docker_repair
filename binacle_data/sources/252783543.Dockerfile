FROM node:alpine  
ADD . /museomalvinas/  
WORKDIR /museomalvinas/  
RUN npm install  
RUN npm install -g supervisor  
CMD ["supervisor","server.js"]  

