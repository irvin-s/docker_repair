FROM node:4.2.2  
MAINTAINER Computes <info@computes.io>  
  
ENV PATH $PATH:/usr/local/bin  
  
RUN mkdir -p /usr/src/computes  
WORKDIR /usr/src/computes  
  
COPY package.json /usr/src/computes/  
RUN npm install --production  
COPY . /usr/src/computes  
  
CMD [ "node", "index.js", "1"]  

