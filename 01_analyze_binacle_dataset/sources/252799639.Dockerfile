FROM golang:alpine  
MAINTAINER Siddhartha Basu <siddhartha-basu@northwestern.edu>  
COPY . /usr/src/app  
RUN cd /usr/src/app \  
&& apk add --no-cache --virtual .gman git \  
&& apk add --no-cache postgresql \  
&& go-wrapper download \  
&& go build \  
&& cp app ${GOPATH}/bin/ \  
&& apk del .gman  
  

