FROM coursemology/evaluator-image-c_cpp:latest  
MAINTAINER Coursemology <coursemology@googlegroups.com>  
  
RUN apt-get update && apt-get install -y --force-yes \  
nodejs \  
nodejs-legacy \  
nodejs-dev \  
npm \  
&& rm -rf /var/lib/apt/lists/* \  
&& npm install -g jasmine jasmine-reporters  
ENV NODEJS=/usr/bin/nodejs  
ENV NODE_PATH=/usr/local/lib/node_modules  

