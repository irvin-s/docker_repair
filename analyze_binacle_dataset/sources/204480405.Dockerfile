FROM golang:1.7

RUN mkdir -p /go/src/github.com/pagarme/teleport/
WORKDIR /go/src/github.com/pagarme/teleport/

ADD . /go/src/github.com/pagarme/teleport/

RUN go get -u github.com/jteeuwen/go-bindata/...

RUN make install
