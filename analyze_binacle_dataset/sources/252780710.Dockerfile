FROM mhart/alpine-node:latest  
MAINTAINER Corbin Uselton <corbinu@decimal.io>  
  
ENV NODE_ENV production  
ENV NPM_TOKEN ""  
RUN apk add --no-cache make gcc g++ python git  
  
RUN mkdir -p /install  
RUN echo "//registry.npmjs.org/:_authToken=\${NPM_TOKEN}" > ~/.npmrc  
WORKDIR /install  
  
RUN npm install -g node-gyp prebuild  
  
CMD [ "npm install" ]  

