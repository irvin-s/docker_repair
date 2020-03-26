FROM golang:1.5.3
MAINTAINER Eric Holmes <eric@remind101.com>

ADD . /go/src/github.com/remind101/ecsdog
WORKDIR /go/src/github.com/remind101/ecsdog
RUN GO15VENDOREXPERIMENT=1 go install ./cmd/ecsdog

ENTRYPOINT ["/go/bin/ecsdog"]
