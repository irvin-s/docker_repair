FROM golang:alpine  
MAINTAINER Alexandre Ferland <aferlandqc@gmail.com>  
  
RUN apk add --no-cache git  
  
COPY *.go members.json /go/src/memberapi/  
WORKDIR /go/src/memberapi  
RUN go-wrapper download  
RUN go-wrapper install  
  
EXPOSE 1323  
CMD ["/go/bin/memberapi"]  

