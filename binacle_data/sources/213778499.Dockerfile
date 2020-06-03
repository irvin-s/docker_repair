FROM centos

MAINTAINER Lothar Wieske <lothar.wieske@gmail.com>

RUN yum update -y && \
    curl --insecure --junk-session-cookies --location --remote-name --silent --header "Cookie: oraclelicense=accept-securebackup-cookie" http://download.oracle.com/otn-pub/java/jdk/8u161-b12/2f38c3b165be4555a1fa6e98c45e0808/jre-8u161-linux-x64.rpm && \
    yum localinstall -y jre-8u161-linux-x64.rpm && \
    rm jre-8u161-linux-x64.rpm && \
    yum clean all

ENV JAVA_HOME=/usr/java/jre1.8.0_161/ \
    LANG=en_US.UTF-8 \
    LC_ALL=en_US.UTF-8
