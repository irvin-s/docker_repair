FROM node:6  
  
# Server installation  
COPY server/ /usr/src/aicha.photos/server  
WORKDIR /usr/src/aicha.photos/server  
RUN npm install  
  
# Frontend installation  
COPY client/ /usr/src/aicha.photos/client  
  
EXPOSE 7800  
CMD [ "node", "index.js" ]  

