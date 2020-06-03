FROM golang:1.8-alpine

# Setup an env var to where the binary will be on the container
ENV BUILDPATH /go/src/app


# We need Git in order to go get.
# Install git and dependencies then delete git.
RUN apk add --no-cache git \
    && go get github.com/constabulary/gb/... \
    && go get github.com/smartystreets/goconvey \
    && apk del git

# Goconvey runs on 8080, expose it so it can be remapped.
EXPOSE 8080

ENV PROJECT_DIR=$BUILDPATH
ENV GOPATH="$PROJECT_DIR/vendor:$PROJECT_DIR"

RUN echo $PROJECT_DIR
RUN echo $GOPATH

WORKDIR $BUILDPATH
CMD ["goconvey", "-host", "0.0.0.0"]
