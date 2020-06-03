FROM golang:alpine  
  
RUN apk update; apk add git  
RUN go get -u github.com/golang/dep/cmd/dep  
  
CMD ["/bin/sh"]

