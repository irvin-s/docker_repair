FROM blacklabelops/alpine:3.7

ARG JAVA_DISTRIBUTION=jre
ARG JAVA_MAJOR_VERSION=8
ARG JAVA_UPDATE_VERSION=latest
ARG JAVA_BUILD_NUMBER=
ARG JAVA_HASH=
ARG BUILD_DATE=undefined

RUN if  [ "${JAVA_DISTRIBUTION}" = "jre" ]; \
      then export JAVA_PACKAGE_POSTFIX_VERSION=-jre ; \
      else export JAVA_PACKAGE_POSTFIX_VERSION= ; \
    fi && \
    export JAVA_VERSION=${JAVA_MAJOR_VERSION}.${JAVA_UPDATE_VERSION}.${JAVA_BUILD_NUMBER} && \
    if  [ "${JAVA_UPDATE_VERSION}" = "latest" ]; \
      then apk add --update openjdk${JAVA_MAJOR_VERSION}${JAVA_PACKAGE_POSTFIX_VERSION} ; \
      else apk add --update "openjdk${JAVA_MAJOR_VERSION}${JAVA_PACKAGE_POSTFIX_VERSION}=${JAVA_VERSION}" ; \
    fi && \
    # Clean caches and tmps
    rm -rf /var/cache/apk/* && \
    rm -rf /tmp/* && \
    rm -rf /var/log/*

ENV JAVA_HOME=/usr/lib/jvm/default-jvm
ENV PATH=$JAVA_HOME/bin:$PATH

LABEL com.blacklabelops.image.name.java="java-"${JAVA_DISTRIBUTION}"-base-image" \
      com.blacklabelops.application.name.java="java" \
      com.blacklabelops.application.version.java=${JAVA_DISTRIBUTION}${JAVA_MAJOR_VERSION}"-"${JAVA_UPDATE_VERSION}"-b"${JAVA_BUILD_NUMBER} \
      com.blacklabelops.image.builddate.java=${BUILD_DATE}
