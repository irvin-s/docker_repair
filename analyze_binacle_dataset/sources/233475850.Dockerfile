# From base OS image
FROM eason02/centos:7

# Maintainer
MAINTAINER eason.lau02@hotmail.com

RUN yum -y update && \
    yum -y install wget && \
    wget --no-cookies --no-check-certificate --header "Cookie: gpw_e24=http%3A%2F%2Fwww.oracle.com%2F; oraclelicense=accept-securebackup-cookie" "http://download.oracle.com/otn-pub/java/jdk/8u112-b15/jdk-8u112-linux-x64.rpm" && \
    yum -y localinstall jdk-8u112-linux-x64.rpm && \
    rm -f ~/jdk-8u112-linux-x64.rpm
