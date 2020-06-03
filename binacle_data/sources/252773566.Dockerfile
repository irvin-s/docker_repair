FROM node:4.4.2  
MAINTAINER alienblog@outlook.com  
  
RUN \  
mkdir -p /opt/mama2  
  
ADD . /opt/mama2  
  
WORKDIR /opt/mama2  
  
RUN npm install  
  
EXPOSE 80  
ENTRYPOINT ["node", "index.js"]

