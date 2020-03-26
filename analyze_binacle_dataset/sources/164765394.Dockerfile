FROM centos:7
MAINTAINER Daniël van Eeden <docker@myname.nl>

ADD mysql-cluster-gpl-7.4.12-linux-glibc2.5-x86_64.tar.gz /opt/
RUN mv /opt/mysql-cluster-gpl-7.4.12-linux-glibc2.5-x86_64 /opt/mysql

RUN yum -y install libaio
RUN groupadd mysql
RUN useradd -g mysql -s /sbin/nologin mysql
