FROM debian:jessie

COPY apt-install apt-remove /

############
# Oracle JDK
############

# Preparation

ENV JAVA_VERSION 7u80
ENV JAVA_BUILD 15
ENV JAVA_HOME /etc/jdk-${JAVA_VERSION}-b${JAVA_BUILD}

# Installation

USER root
RUN /apt-install wget \
    && cd /tmp \
    && wget --no-check-certificate --no-cookies --header "Cookie: oraclelicense=accept-securebackup-cookie" http://download.oracle.com/otn-pub/java/jdk/${JAVA_VERSION}-b${JAVA_BUILD}/jdk-${JAVA_VERSION}-linux-x64.tar.gz \
    && /apt-remove wget \
    && mkdir jdk-${JAVA_VERSION}-linux-x64 \
    && tar -zxvf jdk-${JAVA_VERSION}-linux-x64.tar.gz --directory jdk-${JAVA_VERSION}-linux-x64 --strip-components=1 \
    && mv jdk-${JAVA_VERSION}-linux-x64 ${JAVA_HOME} \
    && rm jdk-${JAVA_VERSION}-linux-x64.tar.gz \
    && rm -rf ${JAVA_HOME}/*src.zip \
           ${JAVA_HOME}/lib/missioncontrol \
           ${JAVA_HOME}/lib/visualvm \
           ${JAVA_HOME}/lib/*javafx* \
           ${JAVA_HOME}/jre/lib/plugin.jar \
           ${JAVA_HOME}/jre/lib/ext/jfxrt.jar \
           ${JAVA_HOME}/jre/bin/javaws \
           ${JAVA_HOME}/jre/lib/javaws.jar \
           ${JAVA_HOME}/jre/lib/desktop \
           ${JAVA_HOME}/jre/plugin \
           ${JAVA_HOME}/jre/lib/deploy* \
           ${JAVA_HOME}/jre/lib/*javafx* \
           ${JAVA_HOME}/jre/lib/*jfx* \
           ${JAVA_HOME}/jre/lib/amd64/libdecora_sse.so \
           ${JAVA_HOME}/jre/lib/amd64/libprism_*.so \
           ${JAVA_HOME}/jre/lib/amd64/libfxplugins.so \
           ${JAVA_HOME}/jre/lib/amd64/libglass.so \
           ${JAVA_HOME}/jre/lib/amd64/libgstreamer-lite.so \
           ${JAVA_HOME}/jre/lib/amd64/libjavafx*.so \
           ${JAVA_HOME}/jre/lib/amd64/libjfx*.so

ENV PATH ${PATH}:${JAVA_HOME}/bin

# Cleanup

RUN unset JAVA_VERSION

#########
# Testing
#########

RUN env
RUN java -version
RUN javac -version

