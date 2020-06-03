FROM golang:1.9.2

RUN mkdir /go/src/EventAgent

COPY ./EventAgent.go  /go/src/EventAgent/

RUN go get k8s.io/client-go/...

RUN go build -i /go/src/EventAgent/EventAgent.go

