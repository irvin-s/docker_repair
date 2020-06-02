FROM clojure:lein-2.7.1-alpine

RUN mkdir -p /opt/driver/src && \
    adduser ${BUILD_USER} -u ${BUILD_UID} -D -h /opt/driver/src


RUN apk add --no-cache make git curl ca-certificates
WORKDIR /opt/driver/src
