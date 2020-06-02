FROM golang:1.3.3

MAINTAINER lonli078

add irc.go /go/

RUN go build -v -o go-irc-server
RUN rm irc.go

ENTRYPOINT ./go-irc-server -d

