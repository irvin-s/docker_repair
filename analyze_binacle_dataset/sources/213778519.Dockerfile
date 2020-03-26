FROM centos

MAINTAINER Lothar Wieske <lothar.wieske@gmail.com>

RUN yum update -y && \
    curl --insecure --junk-session-cookies --location --remote-name --silent --header "Cookie: oraclelicense=accept-securebackup-cookie" http://download.oracle.com/otn-pub/java/jdk/8u172-b11/a58eab1ec242421181065cdc37240b08/server-jre-8u172-linux-x64.tar.gz  && \
    mkdir -p /usr/java && \
    gunzip server-jre-8u172-linux-x64.tar.gz && \
    tar xf server-jre-8u172-linux-x64.tar -C /usr/java && \
    alternatives --install /usr/bin/java java /usr/java/jdk1.8.0_172/bin/java 1 && \
    alternatives --install /usr/bin/jar  jar  /usr/java/jdk1.8.0_172/bin/jar  1 && \
    rm server-jre-8u172-linux-x64.tar && \
    yum clean all

ENV JAVA_HOME=/usr/java/jdk1.8.0_172/ \
    LANG=en_US.UTF-8 \
    LC_ALL=en_US.UTF-8
