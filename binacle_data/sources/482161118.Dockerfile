FROM golang:1.6
MAINTAINER Rob Van Mieghem

ENV CGO_ENABLED 0
WORKDIR /go/src/github.com/robvanmieghem/siapool

EXPOSE 9985

ENTRYPOINT go build && ./siapool -d
