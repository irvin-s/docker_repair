FROM golang:1.6-wheezy

RUN go get github.com/tools/godep

WORKDIR $GOPATH/src/github.com/guilhermebr/backenderia/backend

ADD . $GOPATH/src/github.com/guilhermebr/backenderia/backend

RUN godep restore

CMD ["go", "run", "main.go"]
