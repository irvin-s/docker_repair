FROM quay.io/dollarshaveclub/golang-protobuf:master

RUN mkdir -p /go/src/github.com/dollarshaveclub/furan
ADD . /go/src/github.com/dollarshaveclub/furan

WORKDIR /go/src/github.com/dollarshaveclub/furan
RUN ./docker-build.sh

CMD ["/go/bin/furan"]
