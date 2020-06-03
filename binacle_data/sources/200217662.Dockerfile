FROM golang:latest

ADD . /go/src/github.com/qfarm/qfarm

WORKDIR /go/src/github.com/qfarm/qfarm

RUN go get github.com/qfarm/qfarm/cmd/server

EXPOSE 8080
CMD /go/bin/server
