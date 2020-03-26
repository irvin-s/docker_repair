FROM alpine

MAINTAINER Lothar Wieske <lothar.wieske@gmail.com>

RUN cd /tmp                                                              && \
    apk add --no-cache --virtual=build-dependencies ca-certificates wget && \
    export GLIBC_VERSION="2.23-r3"                                  && \
    export JAVA_PACKAGE="server-jre"                                    && \
    export JAVA_UPDATE="40"                                      && \
    export JAVA_BUILD="26"                                        && \
    export GLIBC_URL="https://github.com/sgerrand/alpine-pkg-glibc/releases/download/${GLIBC_VERSION}" && \
    export GLIBC_APK="glibc-${GLIBC_VERSION}.apk"                        && \
    export GLIBC_BIN_APK="glibc-bin-${GLIBC_VERSION}.apk"                && \
    export JAVA_URL="http://download.oracle.com/otn-pub/java/jdk/8u${JAVA_UPDATE}-b${JAVA_BUILD}" && \
    export JAVA_TGZ="${JAVA_PACKAGE}-8u${JAVA_UPDATE}-linux-x64.tar.gz"  && \
    export JAVA_HOME="/usr/lib/jvm/default-jvm"                          && \
    wget -q ${GLIBC_URL}/${GLIBC_APK}                                    && \
    wget -q ${GLIBC_URL}/${GLIBC_BIN_APK}                                && \
    apk add --no-cache --allow-untrusted ${GLIBC_APK}                    && \
    apk add --no-cache --allow-untrusted ${GLIBC_BIN_APK}                && \
    echo 'hosts: files mdns4_minimal [NOTFOUND=return] dns mdns4' >> /etc/nsswitch.conf && \
    mkdir -p /usr/lib/jvm                                                && \
    wget -qO- --header "Cookie: oraclelicense=accept-securebackup-cookie;" ${JAVA_URL}/${JAVA_TGZ} | tar -xzf -  && \
    if [ ${JAVA_PACKAGE} = "server-jre" ]; then mv jdk*/jre /usr/lib/jvm/java-8-oracle; else mv j* /usr/lib/jvm/java-8-oracle; fi && \
    ln -s java-8-oracle $JAVA_HOME                                       && \
    rm -rf $JAVA_HOME/*src.zip                                           && \
    rm -rf \
            ${JAVA_HOME}/*/javaws \
            ${JAVA_HOME}/*/jjs \
            ${JAVA_HOME}/*/keytool \
            ${JAVA_HOME}/*/orbd \
            ${JAVA_HOME}/*/pack200 \
            ${JAVA_HOME}/*/policytool \
            ${JAVA_HOME}/*/rmid \
            ${JAVA_HOME}/*/rmiregistry \
            ${JAVA_HOME}/*/servertool \
            ${JAVA_HOME}/*/tnameserv \
            ${JAVA_HOME}/*/unpack200 \
            ${JAVA_HOME}/*/*javafx* \
            ${JAVA_HOME}/*/*jfx* \
            ${JAVA_HOME}/*/amd64/libdecora_sse.so \
            ${JAVA_HOME}/*/amd64/libfxplugins.so \
            ${JAVA_HOME}/*/amd64/libglass.so \
            ${JAVA_HOME}/*/amd64/libgstreamer-lite.so \
            ${JAVA_HOME}/*/amd64/libjavafx*.so \
            ${JAVA_HOME}/*/amd64/libjfx*.so \
            ${JAVA_HOME}/*/amd64/libprism_*.so \
            ${JAVA_HOME}/*/deploy* \
            ${JAVA_HOME}/*/desktop \
            ${JAVA_HOME}/*/ext/jfxrt.jar \
            ${JAVA_HOME}/*/ext/nashorn.jar \
            ${JAVA_HOME}/*/javaws.jar \
            ${JAVA_HOME}/*/jfr \
            ${JAVA_HOME}/*/jfr \
            ${JAVA_HOME}/*/jfr.jar \
            ${JAVA_HOME}/*/missioncontrol \
            ${JAVA_HOME}/*/oblique-fonts \
            ${JAVA_HOME}/*/plugin.jar \
            ${JAVA_HOME}/*/visualvm \
            ${JAVA_HOME}/man \
            ${JAVA_HOME}/plugin \
            ${JAVA_HOME}/*.txt \
            ${JAVA_HOME}/*/*/javaws \
            ${JAVA_HOME}/*/*/jjs \
            ${JAVA_HOME}/*/*/keytool \
            ${JAVA_HOME}/*/*/orbd \
            ${JAVA_HOME}/*/*/pack200 \
            ${JAVA_HOME}/*/*/policytool \
            ${JAVA_HOME}/*/*/rmid \
            ${JAVA_HOME}/*/*/rmiregistry \
            ${JAVA_HOME}/*/*/servertool \
            ${JAVA_HOME}/*/*/tnameserv \
            ${JAVA_HOME}/*/*/unpack200 \
            ${JAVA_HOME}/*/*/*javafx* \
            ${JAVA_HOME}/*/*/*jfx* \
            ${JAVA_HOME}/*/*/amd64/libdecora_sse.so \
            ${JAVA_HOME}/*/*/amd64/libfxplugins.so \
            ${JAVA_HOME}/*/*/amd64/libglass.so \
            ${JAVA_HOME}/*/*/amd64/libgstreamer-lite.so \
            ${JAVA_HOME}/*/*/amd64/libjavafx*.so \
            ${JAVA_HOME}/*/*/amd64/libjfx*.so \
            ${JAVA_HOME}/*/*/amd64/libprism_*.so \
            ${JAVA_HOME}/*/*/deploy* \
            ${JAVA_HOME}/*/*/desktop \
            ${JAVA_HOME}/*/*/ext/jfxrt.jar \
            ${JAVA_HOME}/*/*/ext/nashorn.jar \
            ${JAVA_HOME}/*/*/javaws.jar \
            ${JAVA_HOME}/*/*/jfr \
            ${JAVA_HOME}/*/*/jfr \
            ${JAVA_HOME}/*/*/jfr.jar \
            ${JAVA_HOME}/*/*/missioncontrol \
            ${JAVA_HOME}/*/*/oblique-fonts \
            ${JAVA_HOME}/*/*/plugin.jar \
            ${JAVA_HOME}/*/*/visualvm \
            ${JAVA_HOME}/*/man \
            ${JAVA_HOME}/*/plugin \
            ${JAVA_HOME}/*.txt \
                                                                         && \
    apk del build-dependencies                                           && \
    ln -s $JAVA_HOME/bin/* /usr/bin/                                     && \
    rm -rf /tmp/*

ENV JAVA_HOME=/usr/lib/jvm/default-jvm/ \
    PATH=${PATH}:/usr/lib/jvm/default-jvm/bin
