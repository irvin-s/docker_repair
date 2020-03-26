FROM alpine:3.7

RUN mkdir -p /opt/driver/src && \
    adduser ${BUILD_USER} -u ${BUILD_UID} -D -h /opt/driver/src


RUN apk add --no-cache make git curl ca-certificates bash openjdk8="$RUNTIME_NATIVE_VERSION"

# there is not apk package for gradle, so let's intall it
ENV GRADLE_VERSION 2.13
ENV GRADLE_HOME /usr/lib/gradle/gradle-${GRADLE_VERSION}
ENV PATH ${PATH}:${GRADLE_HOME}/bin

WORKDIR /usr/lib/gradle
RUN set -x \
        && apk add --no-cache wget \
        && wget https://services.gradle.org/distributions/gradle-${GRADLE_VERSION}-bin.zip \
        && unzip gradle-${GRADLE_VERSION}-bin.zip \
        && rm gradle-${GRADLE_VERSION}-bin.zip \
        && apk del wget


WORKDIR /opt/driver/src
