FROM golang:1.7.1
MAINTAINER Atsushi Nagase<a@ngs.io>

ADD . /go/src/github.com/ngs/wiplock
RUN go install github.com/ngs/wiplock

ENTRYPOINT ["/go/bin/wiplock"]
EXPOSE 8000
