FROM alpine:3.5

RUN mkdir -p /opt/driver/src && \
    adduser $BUILD_USER -u $BUILD_UID -D -h /opt/driver/src

RUN apk add --no-cache make git curl maven openjdk8="$RUNTIME_NATIVE_VERSION"

WORKDIR /opt/driver/src