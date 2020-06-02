FROM golang:1.8-alpine

# Setup an env var to where the binary will be on the container
ENV BUILDPATH /go/src/app

# We need Git in order to go get.
# Install git and dependencies then delete git.
RUN apk add --no-cache git \
    && go get github.com/constabulary/gb/... \
    && go get github.com/cespare/reflex \
    && apk del git

# Set all environment variables
ENV APP_PORT 8000
EXPOSE $APP_PORT

WORKDIR $BUILDPATH
CMD ["reflex", "-c", "reflex.conf"]
