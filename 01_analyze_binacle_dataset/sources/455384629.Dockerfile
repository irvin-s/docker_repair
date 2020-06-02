# vim: set filetype=dockerfile:

FROM golang:1.8
MAINTAINER dbarroso@dravetech.com

RUN go get github.com/osrg/gobgp/gobgpd; \
	go get github.com/osrg/gobgp/gobgp; \
    go get github.com/Sirupsen/logrus; \
    go get github.com/armon/go-radix; \
    go get github.com/eapache/channels; \
    go get github.com/golang/protobuf/proto; \
    go get github.com/influxdata/influxdb/client/v2; \
    go get github.com/satori/go.uuid; \
    go get github.com/spf13/cobra; \
    go get github.com/spf13/viper; \
    go get golang.org/x/net/context; \
    go get google.golang.org/grpc; \
    go get gopkg.in/tomb.v2;

WORKDIR $GOPATH/src/github.com/osrg/gobgp/gobgp/lib

RUN go build -ldflags=-s --buildmode=c-shared -o libgobgp.so *go

RUN apt-get update; \
    apt-get install -y python-pip python-dev; \
    pip install grpcio


WORKDIR /gobgprest

ENTRYPOINT ["sleep", "infinity"]
