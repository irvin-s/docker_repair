FROM centos

MAINTAINER Lothar Wieske <lothar.wieske@gmail.com>

RUN yum update -y && \
    curl --insecure --junk-session-cookies --location --remote-name --silent --header "Cookie: oraclelicense=accept-securebackup-cookie" http://download.oracle.com/otn-pub/java/jdk/8u191-b12/2787e4a523244c269598db4e85c51e0c/jdk-8u191-linux-x64.rpm && \
    yum localinstall -y jdk-8u191-linux-x64.rpm && \
    rm jdk-8u191-linux-x64.rpm && \
    yum clean all

ENV JAVA_HOME=/usr/java/jdk1.8.0_191/ \
    LANG=en_US.UTF-8 \
    LC_ALL=en_US.UTF-8
