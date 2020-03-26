# We use a multistage build to avoid bloating our deployment image with build dependencies
FROM golang:1.10.3-alpine3.8 as builder
MAINTAINER Monax <support@monax.io>

# Image must be built from monorepo root
ARG REPO=$GOPATH/src/github.com/monax/bosmarmot
COPY ./vent/ $REPO/vent
COPY ./vendor/ $REPO/vent/vendor/
WORKDIR $REPO/vent

# Dependencies
RUN apk add --update gcc g++
# Build purely static binaries
RUN go build --ldflags '-extldflags "-static"' -o bin/vent .

# N.B. Actual runtime container definitions starts here!
#
# This will be our base container image
FROM alpine:3.8

# We like it when TLS works
RUN apk add --no-cache ca-certificates

ARG REPO=/go/src/github.com/monax/bosmarmot/vent

# Copy binaries built in previous stage
COPY --from=builder $REPO/bin/* /usr/local/bin/

ENTRYPOINT [ "vent" ]
