FROM golang:1.7.4-alpine

WORKDIR /go/src/github.com/hyleung/docker-stats
COPY . ./

RUN go get