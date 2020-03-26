FROM centos:7

MAINTAINER Zhanwei Wang <wangzw@wangzw.org>

# install document with yum
RUN sed -i 's/tsflags=nodocs//g' /etc/yum.conf

# add yum repo
RUN curl -L "https://bintray.com/wangzw/rpm/rpm" -o /etc/yum.repos.d/bintray-wangzw-rpm.repo

# install all software we need
RUN yum -y swap -- remove systemd-container systemd-container-libs -- install systemd systemd-libs && \
 yum install -y epel-release && \
 yum makecache && \
 yum install -y man passwd sudo tar which git mlocate links make bzip2 net-tools \
 autoconf automake libtool m4 gcc gcc-c++ gdb bison flex cmake gperf maven indent \
 libuuid-devel krb5-devel libgsasl-devel expat-devel libxml2-devel \
 perl-ExtUtils-Embed pam-devel python-devel libcurl-devel snappy-devel \
 thrift-devel libyaml-devel libevent-devel bzip2-devel openssl-devel \
 openldap-devel protobuf-devel readline-devel net-snmp-devel apr-devel \
 libesmtp-devel xerces-c-devel python-pip json-c-devel libhdfs3-devel \
 apache-ivy java-1.7.0-openjdk-devel \
 openssh-clients openssh-server && \
 yum clean all

# install python module 
RUN yum makecache && yum install -y postgresql-devel && \
 pip --retries=50 --timeout=300 install pg8000 simplejson unittest2 pycrypto pygresql pyyaml lockfile paramiko psi && \
 pip --retries=50 --timeout=300 install http://darcs.idyll.org/~t/projects/figleaf-0.6.1.tar.gz && \
 pip --retries=50 --timeout=300 install http://sourceforge.net/projects/pychecker/files/pychecker/0.8.19/pychecker-0.8.19.tar.gz/download && \
 yum erase -y postgresql postgresql-libs postgresql-devel && \
 yum clean all

# setup ssh server and keys for root
RUN sshd-keygen && \
 ssh-keygen -t rsa -N "" -f ~/.ssh/id_rsa && \
 cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys && \
 chmod 0600 ~/.ssh/authorized_keys

# setup JAVA_HOME for all users
RUN echo "#!/bin/sh" > /etc/profile.d/java.sh && \
 echo "export JAVA_HOME=/etc/alternatives/java_sdk" >> /etc/profile.d/java.sh && \
 chmod a+x /etc/profile.d/java.sh

# install libyarn
RUN mkdir -p /tmp/build && \
 cd /tmp/build && git clone --depth=1 https://github.com/apache/incubator-hawq.git . && cd depends/libyarn && mkdir build && cd build && \
 ../bootstrap --prefix=/usr && make && make install && ldconfig && \
 rm -rf /tmp/build

# create user gpadmin since HAWQ cannot run under root
RUN groupadd -g 1000 gpadmin && \
 useradd -u 1000 -g 1000 gpadmin && \
 echo "gpadmin  ALL=(ALL)       NOPASSWD: ALL" > /etc/sudoers.d/gpadmin

# sudo should not require tty
RUN sed -i -e 's|Defaults    requiretty|#Defaults    requiretty|' /etc/sudoers

# set USER env
RUN echo "#!/bin/bash" > /etc/profile.d/user.sh && \
 echo "export USER=\`whoami\`" >> /etc/profile.d/user.sh && \
 chmod a+x /etc/profile.d/user.sh

ENV BASEDIR /data
RUN mkdir -p /data && chmod 777 /data

USER gpadmin

# setup ssh client keys for gpadmin
RUN ssh-keygen -t rsa -N "" -f ~/.ssh/id_rsa && \
 cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys && \
 chmod 0600 ~/.ssh/authorized_keys

WORKDIR /data
