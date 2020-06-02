FROM golang
MAINTAINER joe@cogolabs.com

ADD . /go/src/github.com/cogolabs/slackipmi
RUN go get -x github.com/cogolabs/slackipmi

EXPOSE 80
ENTRYPOINT ["/go/bin/slackipmi"]
