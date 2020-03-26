FROM golang:1.9  
LABEL maintainer "Andrew Tarasenko andrexus@gmail.com"  
  
RUN go get -u github.com/golang/dep/cmd/dep

