FROM mhart/alpine-node:8.10.0  
  
# passo demorado, necessário para dependencias nativas gyp  
RUN apk add \--no-cache make gcc g++ python  

