FROM node:7.5.0-alpine  
MAINTAINER Alexei Aguiar <alexeiaguiar@gmail.com>  
  
USER 0  
WORKDIR /opt  
  
RUN apk update \  
&& apk add git vim curl wget \  
&& rm -rf /var/cache/apk/* \  
&& npm install -g spectacle-docs

