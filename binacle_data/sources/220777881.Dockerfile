FROM golang

ENV GOBIN /go/bin

# Need this for dependency management
RUN curl https://glide.sh/get | sh

# Test watcher
RUN go get github.com/smartystreets/goconvey

# goconvey port
EXPOSE 8080