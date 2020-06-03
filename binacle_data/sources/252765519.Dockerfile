FROM golang:1.6.0-alpine  
  
RUN apk add --update git  
RUN go get github.com/opencontrol/compliance-masonry  
  
WORKDIR /code  

