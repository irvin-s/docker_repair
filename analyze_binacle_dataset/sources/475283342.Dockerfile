FROM golang:1.3.3

ADD . /go/src/github.com/bsphere/lecat

RUN go get github.com/bsphere/lecat

RUN go install github.com/bsphere/lecat

ENTRYPOINT ["/go/bin/lecat"]
