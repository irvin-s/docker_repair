FROM golang:alpine AS builder  
  
ARG SHADOWSOCKS_GO_VERSION=1.2.1  
ARG SHADOWSOCKS_GO_PKG=github.com/shadowsocks/shadowsocks-go  
ARG SHADOWSOCKS_GO_REPO=https://$SHADOWSOCKS_GO_PKG.git  
ARG SHADOWSOCKS_GO_SRC=$GOPATH/src/$SHADOWSOCKS_GO_PKG  
  
RUN apk add --no-cache --virtual .build-deps git  
  
RUN git clone \--branch $SHADOWSOCKS_GO_VERSION \  
$SHADOWSOCKS_GO_REPO $SHADOWSOCKS_GO_SRC  
  
ENV CGO_ENABLED=0  
RUN go get $SHADOWSOCKS_GO_PKG/cmd/shadowsocks-server  
RUN go get $SHADOWSOCKS_GO_PKG/cmd/shadowsocks-local  
  
FROM dochang/confd:latest  
LABEL maintainer="dochang@gmail.com"  
  
COPY \--from=builder /go/bin/* /usr/local/bin/  
  
VOLUME ["/etc/shadowsocks"]  
COPY entrypoint.sh /  
ENTRYPOINT ["/entrypoint.sh"]  

