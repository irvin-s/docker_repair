# Base image with CentOS + systemd + OpenJDK

FROM centos:latest
MAINTAINER Anurag Sharma <anurag.sharma@sixturtle.com>

ENV container docker

# Install updates
RUN yum -y update; yum clean all

# Install systemd
# Systemd primary task is to manage the boot process and provides information about it.
RUN yum -y install systemd; yum clean all; \
(cd /lib/systemd/system/sysinit.target.wants/; for i in *; do [ $i == systemd-tmpfiles-setup.service ] || rm -f $i; done); \
rm -f /lib/systemd/system/multi-user.target.wants/*;\
rm -f /etc/systemd/system/*.wants/*;\
rm -f /lib/systemd/system/local-fs.target.wants/*; \
rm -f /lib/systemd/system/sockets.target.wants/*udev*; \
rm -f /lib/systemd/system/sockets.target.wants/*initctl*; \
rm -f /lib/systemd/system/basic.target.wants/*;\
rm -f /lib/systemd/system/anaconda.target.wants/*;

# Install OpenJDK Development package
RUN yum -y install unzip java-1.8.0-openjdk-devel && yum clean all

# Set the JAVA_HOME variable to make it clear where Java is located
ENV JAVA_HOME /usr/lib/jvm/java
ENV PATH $PATH:/$JAVA_HOME/bin

CMD ["/usr/sbin/init"]
