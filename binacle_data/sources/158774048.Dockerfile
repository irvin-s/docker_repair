FROM golang:1.9.2

ADD . /go/src/github.com/brancz/hlin

RUN cd /go/src/github.com/brancz/hlin && \
    apt-get update && \
    apt-get install unzip && \
    /go/src/github.com/brancz/hlin/scripts/install-protobuf.sh `cat PROTOC_VERSION | tr -d "\n"` && \
    go get github.com/gogo/protobuf/protoc-gen-gofast

WORKDIR /go/src/github.com/brancz/hlin
