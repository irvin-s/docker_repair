FROM golang:1.9.5-alpine3.7  
MAINTAINER Siddhartha Basu <siddhartha-basu@northwestern.edu>  
RUN apk add --no-cache git build-base \  
&& go get github.com/pressly/goose/cmd/goose  
  
FROM alpine:3.7  
RUN apk --no-cache add ca-certificates  
COPY \--from=0 /go/bin/goose /usr/local/bin/  
RUN mkdir -p /usr/src/appdata  
COPY *.sql /usr/src/appdata/  

