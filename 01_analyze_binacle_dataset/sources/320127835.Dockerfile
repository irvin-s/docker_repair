FROM golang:1.9-alpine3.7

RUN mkdir -p /opt/driver/src && \
    adduser ${BUILD_USER} -u ${BUILD_UID} -D -h /opt/driver/src

RUN apk add --no-cache make git curl ca-certificates

WORKDIR /opt/driver/src
