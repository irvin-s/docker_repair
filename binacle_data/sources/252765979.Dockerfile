FROM node:7.7  
WORKDIR /app  
COPY ./package.json /app/package.json  
RUN npm install  
  
COPY ./ /app  
  
EXPOSE 3000  
CMD node server.js  

