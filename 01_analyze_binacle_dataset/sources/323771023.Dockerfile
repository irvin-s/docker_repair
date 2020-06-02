FROM golang:1.10

ENV GO_PACKAGE github.com/znly/go-ml-transpiler/serving/

COPY . /go/src/${GO_PACKAGE}
WORKDIR /go/src/${GO_PACKAGE}

WORKDIR client
