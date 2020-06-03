FROM golang:1.9-alpine  
  
RUN apk update && \  
apk --no-cache add git openssh postgresql && \  
go get -u github.com/kardianos/govendor github.com/jstemmer/go-junit-report  

