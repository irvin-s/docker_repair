FROM alpine:3.9

RUN apk add --no-cache gcc musl-dev

RUN apk add --no-cache rust cargo

RUN apk add --no-cache build-base

RUN apk add --no-cache cmake

RUN apk add --no-cache perl

RUN apk --no-cache add bash go bzr git mercurial subversion openssh-client ca-certificates

RUN mkdir -p /go/src /go/bin && chmod -R 777 /go
ENV GOPATH /go
ENV PATH /go/bin:$PATH
