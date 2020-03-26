FROM golang:onbuild

ENV CGO_ENABLED 0

RUN go build -ldflags "-linkmode external -extldflags -static" -o dnscock

ENTRYPOINT ["/bin/sh"] 
