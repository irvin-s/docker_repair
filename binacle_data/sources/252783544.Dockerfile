FROM node:alpine  
ADD . /triviamalvinas/  
WORKDIR /triviamalvinas/  
RUN npm install  
CMD ["node","server.js"]  

