FROM golang:1.10-stretch

LABEL authors="Julien Neuhart <j.neuhart@thecodingmachine.com>"

# Installs lint dependencies.
RUN go get -u gopkg.in/alecthomas/gometalinter.v2 &&\
    gometalinter.v2 --install

# Defines our working directory.
WORKDIR /go/src/github.com/thegomachine/go-shex

# Copies our Go source.
COPY . .

ENTRYPOINT [ "./docker-entrypoint.sh" ]