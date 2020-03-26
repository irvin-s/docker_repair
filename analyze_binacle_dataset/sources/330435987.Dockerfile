FROM golang:alpine as BASE
WORKDIR /go/src/github.com/sul-dlss-labs/taco
COPY . .
RUN apk update && \
    apk --no-cache add python py-pip py-setuptools ca-certificates make jq && \
    pip --no-cache-dir install awscli && \
    rm -rf /var/cache/apk/* && \
    apk add --no-cache --virtual .build-deps git && \
    go get -u github.com/golang/dep/cmd/dep && \
    dep ensure && \
    apk del .build-deps
