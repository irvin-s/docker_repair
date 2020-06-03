FROM centos:6.4

RUN rpm -ivh http://dl.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm

## patch etc network to get past issue
RUN echo "NETWORKING=yes" > /etc/sysconfig/network

## Get around su/runuser issues
ADD ./runuser.pam     /etc/pam.d/runuser
ADD ./su.pam          /etc/pam.d/su

RUN yum install -y wget

## Include java 7
RUN yum install java-1.7.0-openjdk-devel -y
ENV JAVA_HOME /usr

RUN yum install -y which

## Setup SSH for local ssh
RUN yum install -y openssh-clients openssh-server
RUN mkdir -p /root/.ssh && chmod 700 /root/.ssh
ADD ssh /root/.ssh
