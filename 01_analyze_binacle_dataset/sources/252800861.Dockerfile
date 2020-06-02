FROM golang:alpine as build  
MAINTAINER matthew@walster.org  
LABEL maintainer "matthew@walster.org"  
RUN mkdir -p /go/src/prefixlister  
WORKDIR /go/src/prefixlister/  
COPY . /go/src/prefixlister/  
RUN apk add --no-cache git  
RUN go get -u -x github.com/golang/dep/...  
RUN dep ensure -v  
RUN go install -v  
  
FROM alpine:latest  
WORKDIR /root/  
COPY \--from=build /go/bin/prefixlister .  
RUN mkdir templates  
COPY \--from=build /go/src/prefixlister/templates/ templates/  
ENTRYPOINT ["./prefixlister"]  

