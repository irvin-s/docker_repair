FROM golang:1.10.3

RUN go version
RUN go get -v -u github.com/Sirupsen/logrus
RUN go get -v -u github.com/mitchellh/go-homedir
RUN go get -v -u github.com/pkg/errors

ADD . src/github.com/adamlamar/rungo

# Build supported binaries
RUN go build github.com/adamlamar/rungo
RUN GOOS=darwin go build github.com/adamlamar/rungo
RUN GOOS=windows go build github.com/adamlamar/rungo

# Build binary in $GOPATH/bin/
RUN go install github.com/adamlamar/rungo

# Stage any downloaded tarballs
RUN mkdir -p $HOME/.rungo
RUN cp -r $GOPATH/src/github.com/adamlamar/rungo/go-releases/* $HOME/.rungo/

# Verify the correct go versions are executed
RUN GO_VERSION=1.8 $GOPATH/bin/rungo version | grep "go version go1.8 linux/amd64"
RUN echo "1.9.1" > $GOPATH/.go-version && $GOPATH/bin/rungo version | grep "go version go1.9.1 linux/amd64" && rm $GOPATH/.go-version

# Create "binstubs" for multi binary support
RUN ln -s $GOPATH/bin/rungo $GOPATH/bin/go && ln -s $GOPATH/bin/rungo $GOPATH/bin/godoc && ln -s $GOPATH/bin/rungo $GOPATH/bin/gofmt

RUN GO_VERSION=1.9.2 $GOPATH/bin/go version | grep "go version go1.9.2 linux/amd64"
RUN GO_VERSION=1.9.2 $GOPATH/bin/godoc -q longstringthatdoesntexist

RUN GO_VERSION=1.10.2 $GOPATH/bin/go version | grep "go version go1.10.2 linux/amd64"
RUN echo "package main" | GO_VERSION=1.10.2 $GOPATH/bin/gofmt
