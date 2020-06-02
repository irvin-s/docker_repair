FROM golang:latest

RUN go get github.com/golang/gddo/gddo-server
COPY start.sh /usr/bin/godoc-server

WORKDIR /go/bin

CMD godoc-server
