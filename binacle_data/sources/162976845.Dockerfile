# Apache Zookeeper

FROM openjdk:8-jre-alpine

ARG ZOOKEEPER_VERSION=3.4.10
ARG ZOOKEEPER_MIRROR=http://www-eu.apache.org

LABEL name="zookeeper" version=${ZOOKEEPER_VERSION}

ADD ./src /

RUN chmod +x /usr/local/sbin/start.sh

RUN apk add --no-cache wget bash

RUN mkdir /opt \
  && wget -q -O - ${ZOOKEEPER_MIRROR}/dist/zookeeper/zookeeper-${ZOOKEEPER_VERSION}/zookeeper-${ZOOKEEPER_VERSION}.tar.gz | tar -xzf - -C /opt \
  && mv /opt/zookeeper-* /opt/zookeeper \
  && chown -R root:root /opt/zookeeper

RUN addgroup -S zookeeper \
  && adduser -h /var/lib/zookeeper -G zookeeper -S -H -s /sbin/nologin zookeeper \
  && mkdir /var/lib/zookeeper \
  && chown -R zookeeper:zookeeper /var/lib/zookeeper

EXPOSE 2181 2888 3888

VOLUME ["/opt/zookeeper/conf", "/var/lib/zookeeper"]

ENTRYPOINT ["/usr/local/sbin/start.sh"]
