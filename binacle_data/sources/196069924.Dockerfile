FROM golang:1.7
RUN apt-get -qq update >/dev/null && apt-get -qq install zip >/dev/null
WORKDIR /go/src/github.com/jarpy/factbeat
