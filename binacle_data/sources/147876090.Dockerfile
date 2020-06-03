FROM golang:1.12.1
MAINTAINER zs <gvinaxu@gmail.com>

RUN mkdir -p $GOPATH/src/riverside/
WORKDIR $GOPATH/src/riverside/

add  . * $GOPATH/src/riverside/

ENTRYPOINT ["go", "run" , "/go/src/riverside/main.go"]