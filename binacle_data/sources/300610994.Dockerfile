FROM golang:1.8-wheezy

RUN mkdir -p /go/src/github.com/themotion/ladder
WORKDIR /go/src/github.com/themotion/ladder/

# Github releaser
RUN go get github.com/aktau/github-release

