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
  yum update -y && \
  yum install -y java-${JAVA_VERSION}-openjdk wget && \
  yum clean all

# Zookeeper download
RUN \
  wget -q ${ZK_MIRROR}/zookeeper-${ZK_VERSION}.tar.gz && \ 
  wget -q https://www.apache.org/dist/zookeeper/KEYS && \ 
  wget -q https://www.apache.org/dist/zookeeper/stable/zookeeper-${ZK_VERSION}.tar.gz.asc && \
  wget -q https://www.apache.org/dist/zookeeper/stable/zookeeper-${ZK_VERSION}.tar.gz.md5 

# Verify download
RUN \
  md5sum -c zookeeper-${ZK_VERSION}.tar.gz.md5 && \
  gpg --import KEYS && \
  gpg --verify zookeeper-${ZK_VERSION}.tar.gz.asc 

# Install 
RUN \
  tar xvzf zookeeper-${ZK_VERSION}.tar.gz -C /opt && \
  mv /opt/zookeeper-${ZK_VERSION} /opt/zookeeper && \
  mkdir -p /tmp/zookeeper

# Configure
COPY \
  zoo-ensemble.cfg /opt/zookeeper/conf/zoo.cfg 
  
COPY \
  docker-entrypoint.sh /opt/zookeeper/

EXPOSE 2181 2888 3888    
  
ENTRYPOINT ["/opt/zookeeper/docker-entrypoint.sh"]
