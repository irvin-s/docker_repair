FROM webhippie/alpine:latest  
MAINTAINER tuannvm <tuannvm@mail.ru>  
  
ENV GOPATH /root/go  
  
RUN apk add --update build-base git go mercurial  

