FROM alpine:3.7

RUN mkdir -p /opt/driver/src && \
    adduser ${BUILD_USER} -u ${BUILD_UID} -D -h /opt/driver/src

RUN apk --update upgrade && \
    apk add --no-cache make git curl ca-certificates \
    nodejs="${RUNTIME_NATIVE_VERSION}" nodejs-npm

RUN npm install -g yarn

WORKDIR /opt/driver/src
