FROM golang:latest
MAINTAINER Tomasen "https://github.com/Tomasen"

# Copy the local package files to the container's workspace.
ADD . /go/src/github.com/tomasen/httpdns

# change workdir, build and install
WORKDIR /go/src/github.com/tomasen/httpdns
RUN go get .
RUN go install

RUN rm -rf /go/src/*
WORKDIR /go/bin

# Run the httpdns command by default when the container starts.
ENTRYPOINT /go/bin/httpdns

EXPOSE 1053 1153 1154
