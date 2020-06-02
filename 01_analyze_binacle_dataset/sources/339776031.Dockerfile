#
# Alpine Linux - OpenJDK8 Dockerfile
#

FROM alpine:latest

MAINTAINER Henrik Steen <henrist@henrist.net>

USER root

RUN \
  apk update && \
  apk upgrade && \
  apk add openjdk8 && \
  rm -rf /var/cache/apk/*

ENV JAVA_HOME /usr/lib/jvm/java-1.8-openjdk

WORKDIR /tmp

CMD ["sh"]
