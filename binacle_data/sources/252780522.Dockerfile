#Base image is in https://registry.hub.docker.com/_/golang/  
# Refer to https://blog.golang.org/docker for usage  
FROM golang:latest  
MAINTAINER Aleks  
  
EXPOSE 1323  
ENV GOPATH /go  
  
RUN go get -u github.com/labstack/echo  
RUN go get gopkg.in/mgo.v2/bson  
RUN go get github.com/dgrijalva/jwt-go  
RUN go get gopkg.in/go-playground/validator.v9  
RUN go get github.com/mrjones/oauth  
RUN go get -u github.com/nfnt/resize  
RUN go get -u github.com/gorilla/websocket  
  
RUN mkdir -p /go/src/doggy_go  
ADD . /go/src/doggy_go  
WORKDIR /go/src/doggy_go  
  
ENTRYPOINT go run server.go

