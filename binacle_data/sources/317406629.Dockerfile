# Build hypereth in a stock Go builder container
FROM golang:1.11.1-alpine3.8 as builder

RUN apk add --no-cache make gcc musl-dev linux-headers

ADD . $GOPATH/src/github.com/getamis/hypereth
RUN mkdir /hypereth
RUN cd $GOPATH/src/github.com/getamis/hypereth \
&& go install ./cmd/... \
&& mv -v /go/bin/* /hypereth

# Pull hypereth into a second stage deploy alpine container
FROM alpine:3.8

RUN apk add --no-cache ca-certificates
COPY --from=builder /hypereth /usr/local/bin/
