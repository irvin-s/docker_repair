#
# Apache Zookeeper Dockerfile
#
# https://github.com/bigcontainer/bigcont
#

# Pull base image
FROM centos:7

# Build-time vars
ARG ZK_VERSION=3.4.8
ARG ZK_MIRROR=http://www-eu.apache.org/dist/zookeeper/stable

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
  curl -L https://www.apache.org/dist/zookeeper/stable/zookeeper-${ZK_VERSION}.tar.gz.asc -o /tmp/zookeeper-${ZK_VERSION}.tar.gz.asc && \
  curl -L https://www.apache.org/dist/zookeeper/stable/zookeeper-${ZK_VERSION}.tar.gz.md5 -o /tmp/zookeeper-${ZK_VERSION}.tar.gz.md5 

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
  rm -f /tmp/zookeeper-*

# Configure
RUN \
  cp /opt/zookeeper/conf/zoo_sample.cfg /opt/zookeeper/conf/zoo.cfg && \
  mkdir -p /tmp/zookeeper

EXPOSE 2181 2888 3888    
  
ENTRYPOINT ["/opt/zookeeper/bin/zkServer.sh"]
CMD ["start-foreground"] 
