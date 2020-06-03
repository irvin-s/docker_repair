FROM golang:1.3.3

# install godep
RUN go get github.com/tools/godep

# copy source code
ADD . /go/src/github.com/bsphere/nsq_to_slack

# install godep dependencies
WORKDIR /go/src/github.com/bsphere/nsq_to_slack

RUN godep restore

WORKDIR /go

# build and install the source code
RUN go install github.com/bsphere/nsq_to_slack

ENTRYPOINT ["/go/bin/nsq_to_slack"]
