FROM centos

MAINTAINER Lothar Wieske <lothar.wieske@gmail.com>

RUN yum update -y && \
    curl --insecure --junk-session-cookies --location --remote-name --silent --header "Cookie: oraclelicense=accept-securebackup-cookie" http://download.oracle.com/otn-pub/java/jdk/8u121-b13/e9e7ea248e2c4826b92b3f075a80e441/server-jre-8u121-linux-x64.tar.gz  && \
    mkdir -p /usr/java && \
    gunzip server-jre-8u121-linux-x64.tar.gz && \
    tar xf server-jre-8u121-linux-x64.tar -C /usr/java && \
    alternatives --install /usr/bin/java java /usr/java/jdk1.8.0_121/bin/java 1 && \
    alternatives --install /usr/bin/jar  jar  /usr/java/jdk1.8.0_121/bin/jar  1 && \
    rm server-jre-8u121-linux-x64.tar && \
    yum clean all

ENV JAVA_HOME=/usr/java/jdk1.8.0_121/ \
    LANG=en_US.UTF-8 \
    LC_ALL=en_US.UTF-8
