FROM node:6  
ENV BUILD_DIR=/var/builds  
RUN apt-get update \  
&& apt-get install p7zip-full build-essential -y  
RUN mkdir -p /usr/local/nodejs  
ADD nodejs-init.sh /usr/local/nodejs/nodejs-init.sh  
RUN chmod 755 /usr/local/nodejs/nodejs-init.sh  
RUN mkdir -p $BUILD_DIR  
RUN chmod 755 $BUILD_DIR  

