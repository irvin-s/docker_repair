FROM golang:1-alpine

RUN apk --no-cache add ca-certificates git

RUN go get github.com/blend/go-sdk/examples/echo

ENTRYPOINT /go/bin/echo
EXPOSE 5000