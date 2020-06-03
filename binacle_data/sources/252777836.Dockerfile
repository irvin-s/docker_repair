FROM node:0.10.40  
MAINTAINER AooJ <aooj@n13.cz>  
  
RUN mkdir -p /opt/app  
WORKDIR /opt/app  
  
ADD . /opt/app  
RUN /usr/local/bin/npm install  
  
CMD ["/usr/local/bin/node", "/opt/app/index.js"]

