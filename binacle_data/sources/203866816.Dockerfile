#
# Apache Zookeeper Dockerfile
#
# https://github.com/bigcontainer/bigcont
#

# Pull base image
FROM centos:7

# Build-time vars
ARG ZK_VERSION=3.4.8
ARG ZK_MIRROR=http://www.apache.org/dist/zookeeper/zookeeper-${ZK_VERSION}

# Custom metadata
LABEL name="zookeeper" zookeeper-version=$ZK_VERSION

# Define commonly used JAVA_HOME variable
ENV JAVA_VERSION 1.8.0 
ENV JAVA_HOME /usr/lib/jvm/jre

# Java installation
RUN \
  yum install -y java-${JAVA_VERSION}-openjdk 

# Zookeeper download
RUN \
  curl -L ${ZK_MIRROR}/zookeeper-${ZK_VERSION}.tar.gz -o /tmp/zookeeper-${ZK_VERSION}.tar.gz && \ 
  curl -L https://www.apache.org/dist/zookeeper/KEYS -o /tmp/KEYS && \ 
  curl -L ${ZK_MIRROR}/zookeeper-${ZK_VERSION}.tar.gz.asc -o /tmp/zookeeper-${ZK_VERSION}.tar.gz.asc && \
  curl -L ${ZK_MIRROR}/zookeeper-${ZK_VERSION}.tar.gz.md5 -o /tmp/zookeeper-${ZK_VERSION}.tar.gz.md5 

# Verify download
RUN \
  cd /tmp && \ 
  md5sum -c zookeeper-${ZK_VERSION}.tar.gz.md5 && \
  cd - && \ 
  gpg --import /tmp/KEYS && \
  gpg --verify /tmp/zookeeper-${ZK_VERSION}.tar.gz.asc 

# Install 
RUN \
  tar xvzf /tmp/zookeeper-${ZK_VERSION}.tar.gz -C /opt && \
  mv /opt/zookeeper-${ZK_VERSION} /opt/zookeeper && \
  mkdir -p /tmp/zookeeper && \
  chmod g+w /tmp/zookeeper && \
  chown root: /opt/zookeeper/conf && \
  chmod g+w /opt/zookeeper/conf && \
  rm -f /tmp/zookeeper-*

EXPOSE 2181 2888 3888    

COPY \
    docker-entrypoint.sh /opt/zookeeper/

ENTRYPOINT ["/opt/zookeeper/docker-entrypoint.sh"]

