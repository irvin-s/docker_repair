FROM golang:alpine
MAINTAINER "Shuji Yamada <s-yamada@arukas.io>"

RUN apk add --update ca-certificates git bash make zip && \
    go get github.com/tools/godep && \
    go get github.com/golang/lint/golint && \
    go get github.com/arukasio/cli

WORKDIR $GOPATH/src/github.com/arukasio/cli

RUN godep restore -v .../. && \
    ARUKAS_DEV=1 scripts/build.sh

WORKDIR $GOPATH
ENTRYPOINT ["bin/arukas"]
