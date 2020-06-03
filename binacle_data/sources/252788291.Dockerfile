FROM node:0.12.0-slim  
  
RUN npm install -g \  
grunt-cli \  
bower  
  
EXPOSE 35729  

