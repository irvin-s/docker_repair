FROM golang:1.4

COPY . /go/src/github.com/jbdalido/smg
WORKDIR /go/src/github.com/jbdalido/smg

RUN go build 
