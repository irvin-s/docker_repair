FROM authentise/node-base:2  
MAINTAINER Eli Ribble <eli@authentise.com>  
COPY package.json /src/  
WORKDIR /src  
RUN npm install && npm prune  

