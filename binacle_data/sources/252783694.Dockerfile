FROM node:6  
  
# Server installation  
COPY server/ /usr/src/atelier.landevennec/server  
WORKDIR /usr/src/atelier.landevennec/server  
RUN npm install  
  
# Frontend installation  
COPY client/ /usr/src/atelier.landevennec/client  
  
EXPOSE 7700  
CMD [ "node", "index.js" ]  

