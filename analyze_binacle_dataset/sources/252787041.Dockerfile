FROM node:6  
MAINTAINER Bram Schoenmakers <me@bramschoenmakers.nl>  
  
ENV TW_BASE=/usr/src/app TW_NAME=wiki TW_USER="" TW_PASSWORD="" TW_LAZY=""  
ENV TW_PATH ${TW_BASE}/${TW_NAME}  
  
WORKDIR ${TW_BASE}  
VOLUME ${TW_PATH}  
  
ADD ./run-tiddlywiki.sh /usr/local/bin  
EXPOSE 8080  
ENV TW_VERSION 5.1.11  
RUN npm install --silent -g tiddlywiki@${TW_VERSION}  
  
CMD ["/usr/local/bin/run-tiddlywiki.sh"]  

