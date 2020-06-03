FROM golang:latest
MAINTAINER <author apple-han>

ADD . $GOPATH/src/github.com/apple-han/gosearch
WORKDIR $GOPATH/src/github.com/apple-han/gosearch
RUN go get -v -u github.com/gpmgo/gopm
RUN gopm get -u -v -g github.com/Unknwon/com \
github.com/astaxie/beego/validation \
github.com/boltdb/bolt \
github.com/cznic/kv \
github.com/gin-gonic/gin \
github.com/go-ini/ini \
github.com/huichen/murmur \
github.com/huichen/sego \
github.com/edsrzf/mmap-go \
github.com/cznic/lldb \
github.com/cznic/mathutil

RUN go install github.com/apple-han/gosearch
ENTRYPOINT gosearch

EXPOSE 1230
