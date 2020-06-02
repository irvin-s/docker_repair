FROM golang

RUN go get github.com/hashicorp/serf/serf
RUN go get github.com/op/go-logging
RUN go get github.com/dgryski/go-jump

ADD . /go/src/github.com/kerinin/libring

RUN go install github.com/kerinin/libring/example

# Serf port
EXPOSE 7946

CMD /go/bin/example
