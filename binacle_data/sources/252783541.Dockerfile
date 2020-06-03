FROM node:alpine  
ADD . /concursomalvinas  
WORKDIR /concursomalvinas  
RUN npm install  
CMD ["node","server.js"]  

