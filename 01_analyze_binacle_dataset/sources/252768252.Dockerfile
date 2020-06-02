FROM golang:alpine  
MAINTAINER Alexandre Ferland <aferlandqc@gmail.com>  
  
RUN apk add --no-cache git  
  
ADD . /go/src/github.com/admiralobvious/brevis  
WORKDIR /go/src/github.com/admiralobvious/brevis  
  
RUN go-wrapper download  
RUN go-wrapper install  
  
EXPOSE 1323  
CMD ["/go/bin/brevis", "--address", "0.0.0.0"]  

