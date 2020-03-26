FROM dockette/alpine:3.4

MAINTAINER Milan Sulc <sulcmil@gmail.com>

ENV LANG C.UTF-8
ENV JAVA_HOME /usr/lib/jvm/java-1.8-openjdk
ENV PATH $PATH:/usr/lib/jvm/java-1.8-openjdk/jre/bin:/usr/lib/jvm/java-1.8-openjdk/bin
ENV JAVA_VERSION 8u111
ENV JAVA_ALPINE_VERSION 8.111.14-r0

ENV MAVEN_VERSION=3.3.9
ENV USER_HOME_DIR="/root"
ENV MAVEN_HOME /usr/share/maven
ENV MAVEN_CONFIG "$USER_HOME_DIR/.m2"

# Based on offical OpenJDK image (thank you)
# Based on offical MAVEN image (thank you)

RUN { \
        echo '#!/bin/sh'; \
        echo 'set -e'; \
        echo; \
        echo 'dirname "$(dirname "$(readlink -f "$(which javac || which java)")")"'; \
    } > /usr/local/bin/docker-java-home && \
    chmod +x /usr/local/bin/docker-java-home && \
    set -x && \
    apk add --no-cache openjdk8="$JAVA_ALPINE_VERSION" && \
    [ "$JAVA_HOME" = "$(docker-java-home)" ] && \
    # MAVEN =============================]=======================================
    apk add --no-cache curl tar && \
    mkdir -p /usr/share/maven /usr/share/maven/ref && \
    curl -fsSL http://apache.osuosl.org/maven/maven-3/$MAVEN_VERSION/binaries/apache-maven-$MAVEN_VERSION-bin.tar.gz \
    | tar -xzC /usr/share/maven --strip-components=1 && \
    ln -s /usr/share/maven/bin/mvn /usr/bin/mvn && \
    # CLEANUP ==================================================================
    apk del curl tar && \
    rm -rf /tmp/* /var/cache/apk/*

WORKDIR /data

COPY settings-docker.xml /usr/share/maven/ref/

VOLUME "$USER_HOME_DIR/.m2"

CMD ["mvn"]
