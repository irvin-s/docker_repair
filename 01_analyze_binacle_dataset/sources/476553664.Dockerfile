FROM golang:1.12.1

ENV PATH /go/bin:/usr/local/go/bin:$PATH
ENV GOPATH /go

RUN curl -sfL https://install.goreleaser.com/github.com/golangci/golangci-lint.sh | sh -s -- -b $(go env GOPATH)/bin v1.16.0
