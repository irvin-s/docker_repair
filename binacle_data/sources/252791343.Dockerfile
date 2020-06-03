FROM node:8.2.1  
COPY server.js /usr/src/app/  
  
CMD [ "node", "/usr/src/app/server.js" ]  

