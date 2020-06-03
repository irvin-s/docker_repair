FROM alpine:3.5

ARG RUNTIME_NATIVE_VERSION
ENV RUNTIME_NATIVE_VERSION $RUNTIME_NATIVE_VERSION

RUN apk add --no-cache openjdk8-jre="$RUNTIME_NATIVE_VERSION"

ADD build /opt/driver/bin
CMD /opt/driver/bin/driver