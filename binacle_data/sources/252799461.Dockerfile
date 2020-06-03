FROM golang:alpine  
MAINTAINER "Dennis Webb <dhwebb@gmail.com>"  
RUN apk add --update --no-cache git  
  
WORKDIR $GOPATH/src/github.com/denniswebb/go-license  
COPY main.go .  
RUN go get ./... && \  
go install github.com/denniswebb/go-license  
  
ENTRYPOINT ["go-license"]  

