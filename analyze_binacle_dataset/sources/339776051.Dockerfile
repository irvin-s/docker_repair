FROM frolvlad/alpine-glibc:alpine-3.4
# gliderlabs/alpine:3.4
# alpine:latest
# gliderlabs/alpine:3.2

MAINTAINER totto@totto.org

USER root

# Install packages
RUN \
  echo ipv6 >> /etc/modules && \
  apk update && \
  apk upgrade && \
  apk add --update ca-certificates curl



# Secure the container so that no base users (e.g. root, operator) have a login.
# Provide a script that runs every container invocation (specifically to update Java net.properties).
# Get ready to accept a JVM installation.

ENV JAVA_HOME /usr/local/java
ENV JRE ${JAVA_HOME}/jre
ENV JAVA_OPTS=-Djava.awt.headless=true PATH=${PATH}:${JRE}/bin:${JAVA_HOME}/bin
ENV ENV=/etc/shinit.sh

COPY shinit.sh /etc/

RUN \
  chmod a=rx /etc/shinit.sh && \
  mkdir java

WORKDIR /tmp/java
