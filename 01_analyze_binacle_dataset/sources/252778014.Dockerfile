FROM golang:latest  
MAINTAINER Antoine POPINEAU <antoine.popineau@appscho.com>  
  
COPY . /go/src/github.com/apognu/dummy-server  
RUN go install github.com/apognu/dummy-server  
  
CMD /go/bin/dummy-server  

