FROM golang:alpine  
  
RUN apk add \--no-cache git \  
&& go get -u github.com/golang/dep/cmd/dep  

