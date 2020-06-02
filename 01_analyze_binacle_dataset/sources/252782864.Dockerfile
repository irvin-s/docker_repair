FROM node:latest  
  
MAINTAINER David J <davidj@softcom.com>  
  
ENV INSTALL_PATH /app  
RUN mkdir -p $INSTALL_PATH  
  
WORKDIR $INSTALL_PATH  
  
COPY package.json package.json  
COPY faye-server.js faye-server.js  
  
RUN npm install  
  
EXPOSE 80  
ENTRYPOINT ["npm", "start"]

