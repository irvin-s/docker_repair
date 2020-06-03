FROM golang:1.4.2

MAINTAINER Quanlong He <kyan.ql.he@gmail.com>

# Setup Go and godep
ENV BUILDPATH=/go/src/github.com/cybertk/worktile-events-to-slack
ENV GOPATH=/go:$BUILDPATH/Godeps/_workspace

# Build
COPY . $BUILDPATH
RUN cd $BUILDPATH && go build

CMD $BUILDPATH/worktile-events-to-slack
