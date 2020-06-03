FROM golang:alpine AS builder  
  
ARG COW_VERSION=0.9.8  
ARG COW_PKG=github.com/cyfdecyf/cow  
ARG COW_REPO=https://$COW_PKG.git  
ARG COW_SRC=$GOPATH/src/$COW_PKG  
  
RUN apk add --no-cache --virtual .build-deps git  
  
RUN git clone \--branch $COW_VERSION $COW_REPO $COW_SRC  
  
ENV CGO_ENABLED=0  
RUN go get $COW_PKG  
  
FROM dochang/confd:latest  
LABEL maintainer="dochang@gmail.com"  
  
COPY \--from=builder /go/bin/* /usr/local/bin/  
  
ENV HOME /  
  
EXPOSE 7777  
CMD ["cow"]  

