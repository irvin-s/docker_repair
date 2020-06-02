FROM ubuntu:14.04
MAINTAINER xenron <xenron@hotmail.com>

# install software package
RUN apt-get update -y && \
  apt-get install -y vim tar unzip dnsmasq wget net-tools curl openssh-server nano g++ autoconf automake libtool cmake zlib1g-dev pkg-config libssl-dev 

RUN mkdir -p /opt

# Protocol buffers
RUN wget -q -o out.log -P /tmp https://github.com/google/protobuf/releases/download/v2.5.0/protobuf-2.5.0.tar.gz && \
  tar xzf /tmp/protobuf-2.5.0.tar.gz -C /opt && \
  cd /opt/protobuf-2.5.0 && \
  ./autogen.sh && \
  ./configure --prefix=/usr && \
  make && \
  make check && \
  make install && \
  protoc --version 

# Clean
RUN apt-get clean -y && apt-get autoclean -y && apt-get autoremove -y && \
  rm -rf /var/lib/{apt,dpkg,cache,log}/ && \
  rm -rf /tmp

# Java Version
ENV JAVA_VERSION_MAJOR 8
ENV JAVA_VERSION_MINOR 111
ENV JAVA_VERSION_BUILD 14
ENV JAVA_PACKAGE       jdk

# Download and unarchive Java
RUN curl -jksSLH "Cookie: oraclelicense=accept-securebackup-cookie"\
    http://download.oracle.com/otn-pub/java/jdk/${JAVA_VERSION_MAJOR}u${JAVA_VERSION_MINOR}-b${JAVA_VERSION_BUILD}/${JAVA_PACKAGE}-${JAVA_VERSION_MAJOR}u${JAVA_VERSION_MINOR}-linux-x64.tar.gz | gunzip -c - | tar -xf - -C /opt && \
    ln -s /opt/jdk1.${JAVA_VERSION_MAJOR}.0_${JAVA_VERSION_MINOR} /opt/jdk && \
    rm -rf /opt/jdk/*src.zip \
         /opt/jdk/lib/missioncontrol \
         /opt/jdk/lib/visualvm \
         /opt/jdk/lib/*javafx* \
         /opt/jdk/jre/lib/plugin.jar \
         /opt/jdk/jre/lib/ext/jfxrt.jar \
         /opt/jdk/jre/bin/javaws \
         /opt/jdk/jre/lib/javaws.jar \
         /opt/jdk/jre/lib/desktop \
         /opt/jdk/jre/plugin \
         /opt/jdk/jre/lib/deploy* \
         /opt/jdk/jre/lib/*javafx* \
         /opt/jdk/jre/lib/*jfx* \
         /opt/jdk/jre/lib/amd64/libdecora_sse.so \
         /opt/jdk/jre/lib/amd64/libprism_*.so \
         /opt/jdk/jre/lib/amd64/libfxplugins.so \
         /opt/jdk/jre/lib/amd64/libglass.so \
         /opt/jdk/jre/lib/amd64/libgstreamer-lite.so \
         /opt/jdk/jre/lib/amd64/libjavafx*.so \
         /opt/jdk/jre/lib/amd64/libjfx*.so 

# move all configuration files into container
ADD files/* /usr/local/  

# set environment variable 
ENV JAVA_HOME /opt/jdk 
ENV PATH ${PATH}:${JAVA_HOME}/bin

# configure ssh free key access
RUN mkdir /var/run/sshd && \
  ssh-keygen -t rsa -f ~/.ssh/id_rsa -P '' && \
  cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys && \
  mv /usr/local/ssh_config ~/.ssh/config && \
  sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd

# Hadoop
RUN wget -q -o out.log -P /tmp https://archive.apache.org/dist/hadoop/common/hadoop-2.7.3/hadoop-2.7.3-src.tar.gz && \
  tar xzf /tmp/hadoop-2.7.3-src.tar.gz -C /opt && \
  rm /tmp/hadoop-2.7.3-src.tar.gz && \
  mv /opt/hadoop-2.7.3-src /opt/hadoop

# Spark
RUN wget -q -o out.log -P /tmp https://archive.apache.org/dist/spark/spark-2.1.0/spark-2.1.0.tgz && \
  tar xzf /tmp/spark-2.1.0.tgz -C /opt && \
  rm /tmp/spark-2.1.0.tgz && \
  mv /opt/spark-2.1.0 /opt/spark

# Maven
RUN wget -q -o out.log -P /tmp https://archive.apache.org/dist/maven/maven-3/3.3.9/binaries/apache-maven-3.3.9-bin.tar.gz && \
  tar xzf /tmp/apache-maven-3.3.9-bin.tar.gz -C /opt && \
  rm /tmp/apache-maven-3.3.9-bin.tar.gz && \
  mv /opt/apache-maven-3.3.9 /opt/maven

RUN mv /usr/local/bashrc ~/.bashrc

# compile
RUN . ~/.bashrc && \
  cd /opt/spark && \
  mvn clean -Dhadoop.version=2.7.3 -Pyarn -Phadoop-2.7 -DskipTests clean package


