# Apache Flume Dockerfile
# https://github.com/bigcontainer/bigcont/flume
FROM centos:7

ARG FL_VERSION=1.6.0
ARG FL_MIRROR=http://www-eu.apache.org/dist/

LABEL name="flume" flume-version=$FL_VERSION

ENV JAVA_VERSION=1.8.0 JAVA_HOME=/usr/lib/jvm/jre

# Java installation
RUN \
# We are thinking about avoiding update and trust FROM is updated
# yum update -y && \
  yum install -y java-${JAVA_VERSION}-openjdk && \
  yum clean all
# Flume download
RUN \
  curl -L ${FL_MIRROR}/flume/${FL_VERSION}/apache-flume-${FL_VERSION}-bin.tar.gz -o /tmp/apache-flume-${FL_VERSION}-bin.tar.gz && \ 
  curl -L https://www.apache.org/dist/flume/KEYS -o /tmp/KEYS && \ 
  curl -L https://www.apache.org/dist/flume/${FL_VERSION}/apache-flume-${FL_VERSION}-bin.tar.gz.asc -o /tmp/apache-flume-${FL_VERSION}-bin.tar.gz.asc && \
  curl -L https://www.apache.org/dist/flume/${FL_VERSION}/apache-flume-${FL_VERSION}-bin.tar.gz.md5 -o /tmp/apache-flume-${FL_VERSION}-bin.tar.gz.md5 && \
# Verify download
# Fix wrong MD5 file...
  sed -i "s/$/  apache-flume-${FL_VERSION}-bin.tar.gz/" /tmp/apache-flume-${FL_VERSION}-bin.tar.gz.md5 && \
  cd /tmp && \
  md5sum -c --quiet apache-flume-${FL_VERSION}-bin.tar.gz.md5 && \
  cd - && \
  gpg --import /tmp/KEYS && \
  gpg --verify /tmp/apache-flume-${FL_VERSION}-bin.tar.gz.asc && \
# Install 
  tar xvzf /tmp/apache-flume-${FL_VERSION}-bin.tar.gz -C /opt && \
  mv /opt/apache-flume-${FL_VERSION}-bin /opt/flume && \
  rm -f /tmp/apache-flume-* && \
  rm -f /tmp/KEYS

ADD files/generic.conf /opt/flume/generic.conf

EXPOSE 1234
EXPOSE 34545

WORKDIR /opt/flume 

ENTRYPOINT ["bin/flume-ng", "agent"]
CMD ["-n", "agent", "-c", "conf", "-f", "generic.conf", "-Dflume.root.logger=INFO,console", "-Dflume.monitoring.type=http", "-Dflume.monitoring.port=34545"]
