FROM node:4.4.5  
MAINTAINER Spencer Herzberg <spencer.herzberg@gmail.com>  
  
ENV ESDUMP_VERSION=3.3.1  
RUN npm install -g elasticdump@${ES_DUMP_VERSION}  
  
ENTRYPOINT ["/usr/local/bin/elasticdump"]  

