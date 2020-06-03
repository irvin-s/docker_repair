FROM node:4  
MAINTAINER Bart Teeuwisse <bart@thecodemill.biz>  
  
RUN mkdir /chalet  
ADD chalet.js package.json /chalet/  
RUN cd /chalet && npm install  
  
VOLUME /chalet  
WORKDIR /chalet  
  
CMD ["node", "chalet.js"]  

