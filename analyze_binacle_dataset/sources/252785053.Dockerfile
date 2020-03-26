FROM node:argon  
  
RUN npm install -g supervisor  
  
VOLUME /app  
WORKDIR /app  
CMD [ "supervisor", "--watch", ".", "--no-restart-on", "error", "server.js" ]  

