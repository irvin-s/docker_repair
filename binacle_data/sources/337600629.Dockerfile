# build stage
FROM golang:alpine AS build-env
ADD . /go/src/github.com/yangl900/log2oms

RUN apk add --no-cache git
RUN go get github.com/golang/dep/cmd/dep

WORKDIR /go/src/github.com/yangl900/log2oms/
RUN go test -v && CGO_ENABLED=0 GOOS=linux go build -o log2oms

# final stage
FROM alpine

RUN apk add --no-cache ca-certificates

WORKDIR /log2oms
COPY --from=build-env /go/src/github.com/yangl900/log2oms/log2oms /log2oms

ENTRYPOINT ./log2oms