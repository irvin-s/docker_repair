FROM golang:1.5.1

WORKDIR /go/src/github.com/vikstrous/tox-crawler
ADD . /go/src/github.com/vikstrous/tox-crawler
RUN GOPATH=/go/src/github.com/vikstrous/tox-crawler/Godeps/_workspace:/go go install ./...

CMD ["server"]
