FROM golang:1.4-alpine

RUN apk add --update --no-cache git

ADD . /go/src/github.com/startover/go-martini-fibonacci
WORKDIR /go/src/github.com/startover/go-martini-fibonacci

RUN go get github.com/go-martini/martini
