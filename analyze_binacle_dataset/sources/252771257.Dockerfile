FROM node:4.7.0  
VOLUME ["/config"]  
  
RUN npm i -g borgjs  
  
ENTRYPOINT ["borgjs"]  

