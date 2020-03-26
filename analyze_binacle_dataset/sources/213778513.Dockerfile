FROM centos

MAINTAINER Lothar Wieske <lothar.wieske@gmail.com>

RUN yum update -y && \
    curl --insecure --junk-session-cookies --location --remote-name --silent --header "Cookie: oraclelicense=accept-securebackup-cookie" http://download.oracle.com/otn-pub/java/jdk/8u171-b11/512cd62ec5174c3487ac17c61aaa89e8/server-jre-8u171-linux-x64.tar.gz  && \
    mkdir -p /usr/java && \
    gunzip server-jre-8u171-linux-x64.tar.gz && \
    tar xf server-jre-8u171-linux-x64.tar -C /usr/java && \
    alternatives --install /usr/bin/java java /usr/java/jdk1.8.0_171/bin/java 1 && \
    alternatives --install /usr/bin/jar  jar  /usr/java/jdk1.8.0_171/bin/jar  1 && \
    rm server-jre-8u171-linux-x64.tar && \
    yum clean all

ENV JAVA_HOME=/usr/java/jdk1.8.0_171/ \
    LANG=en_US.UTF-8 \
    LC_ALL=en_US.UTF-8
