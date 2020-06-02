FROM centos

MAINTAINER Lothar Wieske <lothar.wieske@gmail.com>

RUN yum update -y && \
    curl --insecure --junk-session-cookies --location --remote-name --silent --header "Cookie: oraclelicense=accept-securebackup-cookie" http://download.oracle.com/otn-pub/java/jdk/8u162-b12/0da788060d494f5095bf8624735fa2f1/jdk-8u162-linux-x64.rpm && \
    yum localinstall -y jdk-8u162-linux-x64.rpm && \
    rm jdk-8u162-linux-x64.rpm && \
    yum clean all

ENV JAVA_HOME=/usr/java/jdk1.8.0_162/ \
    LANG=en_US.UTF-8 \
    LC_ALL=en_US.UTF-8
