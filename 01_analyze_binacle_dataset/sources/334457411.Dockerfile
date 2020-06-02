FROM golang:alpine

ARG pkg=github.com/census-ecosystem/opencensus-experiments/go/bookshelf

RUN set -ex \
    apk add --no-cache ca-certificates \
      && apk add --no-cache --virtual .build-deps \
              git

RUN go get -v cloud.google.com/go/...

COPY . $GOPATH/src/$pkg
RUN go get -v $pkg/...
RUN go install $pkg/...

# Needed for templates for the front-end app.
WORKDIR $GOPATH/src/$pkg/app

# Users of the image should invoke either of the commands.
CMD echo "Use the app or pubsub_worker commands."; exit 1
