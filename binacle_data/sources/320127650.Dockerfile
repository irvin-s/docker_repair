FROM alpine:3.7

ARG RUNTIME_NATIVE_VERSION
ENV RUNTIME_NATIVE_VERSION $RUNTIME_NATIVE_VERSION

RUN apk add --no-cache openjdk8-jre="$RUNTIME_NATIVE_VERSION"

ADD build /opt/driver
ENTRYPOINT ["/opt/driver/bin/driver"]
