# This Docker file is to create a CENTOS IMAGE for Ambari Node

FROM docker.io/centos:centos6
MAINTAINER Shivaji Dutta

USER root

RUN sed -i -e 's/^tsflags=nodocs/#tsflags=nodocs/g' /etc/yum.conf
RUN yum install -y epel-release
RUN yum install -y dhclient openssh-server openssh-clients supervisor lsof which gcc
RUN yum install -y sudo tar wget ntp passwd


# update libselinux. see https://github.com/sequenceiq/hadoop-docker/issues/14
RUN yum update -y libselinux

# passwordless ssh
RUN ssh-keygen -q -N "" -t dsa -f /etc/ssh/ssh_host_dsa_key
RUN ssh-keygen -q -N "" -t rsa -f /etc/ssh/ssh_host_rsa_key
RUN ssh-keygen -q -N "" -t rsa -f /root/.ssh/id_rsa
RUN cp /root/.ssh/id_rsa.pub /root/.ssh/authorized_keys

RUN /etc/init.d/sshd start


# Hdfs ports
EXPOSE 50010 50020 50070 50075 50090 8082 9000 50470
# Mapred ports
EXPOSE 19888 50030 8021 50060 51111
#Other  ports
EXPOSE 8030 8031 8032 8033 8040 8042 8088 8050 8025 8030 8141 45454 10200 8188 8190 19888 2888 3888 2181
#Other ports
EXPOSE 49707 2122 10000 9083 60000 60010 60020 60030 2888 3888 2181
EXPOSE 50111 88 22 8050

#Ambari port
EXPOSE 8080

# start the linux services
RUN service ntpd start
RUN service sshd start

RUN yum install -y java-1.7.0-openjdk-devel

RUN mkdir /usr/java
RUN ln -s /etc/alternatives/java_sdk_1.7.0 /usr/java/default
