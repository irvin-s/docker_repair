FROM node:5.5.0-slim  
RUN npm install -g gitbook-cli && gitbook install latest  

