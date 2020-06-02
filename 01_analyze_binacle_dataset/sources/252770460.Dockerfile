FROM golang:wheezy  
MAINTAINER Asoseil  
  
RUN mkdir /go/src/project  
WORKDIR /go/src/project  
VOLUME /go/src/project  
  
# install iris framework  
RUN go get github.com/kataras/iris/iris  
#install godep package manager  
RUN go get github.com/tools/godep  
  
ADD main.go /go/src/project  
  
CMD ../../bin/godep save  
CMD ../../bin/iris run main.go  
  
EXPOSE 8080  

