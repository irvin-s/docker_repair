FROM node:latest  
  
RUN mkdir -p /usr/src/app  
COPY . /usr/src/app  
  
RUN cd /usr/src/app && npm install --silent --only=production  
  
WORKDIR /usr/src/app  
  
CMD ["npm", "start"]  

