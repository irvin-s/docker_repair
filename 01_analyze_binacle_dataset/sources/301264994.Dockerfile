# DESCRIPTION:    Oracle Java jdk-6u26
# SOURCE:         https://github.com/rootsongjc/docker-images/tree/master/jdk/jdk6u26
FROM index.tenxcloud.com/jimmy/centos:7.2.1511
MAINTAINER Jimmy Song <rootsongjc@gmail.com>

# Install Oracle JDK 6u26
RUN cd /tmp && \
    curl -L -O -H "Cookie: oraclelicense=accept-securebackup-cookie" -k "http://download.oracle.com/otn-pub/java/jdk/6u26-b06/jdk-6u26-linux-x64-rpm.bin" && \
    yum localinstall -y jdk-6u26-linux-x64-rpm.bin && \
    rm -f jdk-6u26-linux-x64-rpm.bin

# Define commonly used JAVA_HOME variable
ENV JAVA_HOME /usr/java/default

# Add jdk on PATH variable
ENV PATH ${PATH}:${JAVA_HOME}/bin
