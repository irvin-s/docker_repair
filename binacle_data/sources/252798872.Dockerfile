FROM node:0.12.7  
ADD . /app  
  
RUN cd /app && npm install  
  
CMD node /app/examples/mongo.js  

