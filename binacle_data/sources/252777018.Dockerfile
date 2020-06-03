FROM node:8.4.0-alpine  
MAINTAINER Celso Agra  
  
ENV filename=db.json  
  
RUN npm install -g json-server  
  
WORKDIR /data  
VOLUME /data  
  
EXPOSE 80  
ADD init.sh /init.sh  
ENTRYPOINT ["sh", "/init.sh"]

