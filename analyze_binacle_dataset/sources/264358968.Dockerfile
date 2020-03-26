FROM    golang:1.9.4-alpine3.6

RUN     apk add -U git make bash coreutils ca-certificates

ARG     VNDR_SHA=a6e196d8b4b0cbbdc29aebdb20c59ac6926bb384
RUN     go get -d github.com/LK4D4/vndr && \
        cd /go/src/github.com/LK4D4/vndr && \
        git checkout -q "$VNDR_SHA" && \
        go build -v -o /usr/bin/vndr . && \
        rm -rf /go/src/* /go/pkg/* /go/bin/*

WORKDIR /go/src/github.com/fentas/docker-volume-davfs
CMD     sh
