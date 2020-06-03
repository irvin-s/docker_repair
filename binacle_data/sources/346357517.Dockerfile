FROM alpine:3.1
RUN mkdir -p /go
RUN apk add --update \
            go \
            git \
            && export GOPATH=/go
ENV GOPATH /go

WORKDIR /go

RUN go get github.com/samalba/dockerclient

ADD . /go/src/github.com/mjbright/thephedds
WORKDIR /go/src/github.com/mjbright/thephedds
RUN go install github.com/mjbright/thephedds
ENTRYPOINT ["/go/bin/thephedds"]
