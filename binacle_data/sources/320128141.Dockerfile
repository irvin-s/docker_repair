FROM alpine:3.7

RUN apk add --no-cache nodejs="${RUNTIME_NATIVE_VERSION}"

ADD build /opt/driver
ENTRYPOINT ["/opt/driver/bin/driver"]
