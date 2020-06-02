FROM golang:1.8.3

LABEL maintainer "marcelbelmont@gmail.com"

# Set Environment variables
ENV appDir /go/src/github.com/jbelmont/containerized-golang-and-vuejs

# Set the work directory
RUN mkdir -p ${appDir}
WORKDIR ${appDir}
ADD . ${appDir}

COPY Gopkg.toml Gopkg.lock ./

RUN go get -u github.com/golang/dep/cmd/dep && \
    dep ensure

RUN go build
