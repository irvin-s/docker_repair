FROM node:8-alpine  
MAINTAINER Luyi <luyi@newtranx.com>  
  
RUN apk --update add git openssh && \  
rm -rf /var/lib/apt/lists/* && \  
rm /var/cache/apk/*  
  
RUN cd /opt; git clone https://github.com/ansonxing168/glue-router.git  
  
RUN cd /opt/glue-router; npm install  
  
WORKDIR /opt/glue-router  
  
ENTRYPOINT ["node", "src/app.js"]  
  

