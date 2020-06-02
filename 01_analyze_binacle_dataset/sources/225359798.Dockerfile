FROM centos:latest
MAINTAINER PubNative Team <team@pubnative.net>

ENV JAVA_HOME /usr/lib/jvm/jre
ENV LOGSTASH_VERSION 2.4.1

ADD https://download.elastic.co/logstash/logstash/packages/centos/logstash-${LOGSTASH_VERSION}.noarch.rpm /tmp/logstash.rpm

RUN yum update -y && \
    yum install -y \
      logrotate \
      java-1.8.0-openjdk-headless && \
    sed -i "s/#networkaddress.cache.ttl=-1/networkaddress.cache.ttl=60/" ${JAVA_HOME}/lib/security/java.security && \
    rpm -i /tmp/logstash.rpm && \
    rm -f /tmp/logstash.rpm && \
    mkdir -p /opt/logstash/plugins/logstash/filters

ADD ./filters /opt/logstash/plugins/logstash/filters

ENTRYPOINT ["/opt/logstash/bin/logstash", "agent", "-p", "/opt/logstash/plugins"]
