FROM golang:1.7.1  
MAINTAINER Dmitry Yakutkin <dmitry.yakutkin@gmail.com>  
  
ADD . /go/src/github.com/libnetwork-plugin/libnetwork-go  
WORKDIR /go/src/github.com/libnetwork-plugin/libnetwork-go  
CMD /bin/bash -c "./main"  

