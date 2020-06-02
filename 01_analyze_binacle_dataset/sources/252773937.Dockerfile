FROM golang:1.9-alpine AS builder  
  
RUN \  
apk update \  
&& apk add curl git \  
&& rm -rf /var/cache/apk/*  
  
RUN curl https://glide.sh/get | sh  
  
COPY . $GOPATH/src/github.com/ALSAD-project/alsad-core  
WORKDIR $GOPATH/src/github.com/ALSAD-project/alsad-core  
  
RUN glide install  
  
RUN \  
go build \  
-o /usr/local/bin/alsad-dispatcher \  
github.com/ALSAD-project/alsad-core/cmd/dispatcher  
  
FROM alpine:3.6  
ENV PORT 8000  
EXPOSE 8000  
COPY \  
\--from=builder \  
/usr/local/bin/alsad-dispatcher \  
/usr/local/bin/alsad-dispatcher  
  
CMD alsad-dispatcher  

