FROM node:8.11-slim  
  
ENV NPM_CONFIG_LOGLEVEL error  
ENV NPM_VERSION 5.5.1  
  
RUN apt-get update \  
&& apt-get install --assume-yes \--no-install-recommends \  
build-essential git python ssh \  
less vim \  
&& apt-get clean \  
&& rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*  
  
RUN yarn global add node-gyp node-pre-gyp npm@${NPM_VERSION}  

