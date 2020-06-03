# DESCRIPTION:    Oracle Java jdk-8u45
# SOURCE:         https://github.com/rootsongjc/docker-images/tree/master/jdk/jdk8u45
FROM index.tendcloud.com/jimmy/centos:7.2.1511
MAINTAINER Jimmy Song <rootsongjc@gmail.com>

# Install Oracle JDK 8u45
RUN cd /tmp && \
    curl -L -O -H "Cookie: oraclelicense=accept-securebackup-cookie" -k "http://download.oracle.com/otn-pub/java/jdk/8u45-b14/jdk-8u45-linux-x64.rpm" && \
    yum localinstall -y jdk-8u45-linux-x64.rpm && \
    rm -f jdk-8u45-linux-x64.rpm 

# Define commonly used JAVA_HOME variable
ENV JAVA_HOME /usr/java/default

# Add jdk on PATH variable
ENV PATH ${PATH}:${JAVA_HOME}/bin
