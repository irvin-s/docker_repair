FROM mhart/alpine-node:4.4.7  
  
MAINTAINER dan78uk  
  
RUN \  
npm install -g node-gyp && \  
node-gyp install  

