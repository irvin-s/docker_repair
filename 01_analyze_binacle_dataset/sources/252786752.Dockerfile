  
FROM node:6  
# Create app directory  
RUN mkdir -p /FrontEnd  
WORKDIR /FrontEnd  
  
COPY package.json /FrontEnd/  
RUN npm install  

