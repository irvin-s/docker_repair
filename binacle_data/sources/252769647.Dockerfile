# Dockerfile - CentOS 7  
FROM golang:1.8  
  
MAINTAINER Arika Chen <eaglesora@gmail.com>  
  
RUN go get github.com/tools/godep \  
&& go get github.com/openshift/origin \  
&& cd $GOPATH/src/github.com/openshift/origin \  
&& (godep restore || true)  
  

