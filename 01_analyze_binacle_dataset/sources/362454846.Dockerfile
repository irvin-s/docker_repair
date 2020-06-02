FROM centos:6

MAINTAINER Zhanwei Wang <wangzw@wangzw.org>

# install document with yum
RUN sed -i 's/tsflags=nodocs//g' /etc/yum.conf

# install all software we need
RUN yum install -y epel-release && \
 yum makecache && \
 yum install -y man passwd sudo tar which git mlocate links make bzip2 \
 autoconf automake libtool m4 gcc gcc-c++ gdb flex cmake gperf indent \
 libuuid-devel krb5-devel libgsasl-devel expat-devel libxml2-devel \
 perl-ExtUtils-Embed pam-devel python-devel snappy-devel \
 libyaml-devel libevent-devel bzip2-devel openssl-devel \
 openldap-devel readline-devel net-snmp-devel apr-devel \
 libesmtp-devel xerces-c-devel python-pip json-c-devel \
 apache-ivy java-1.7.0-openjdk-devel \
 openssh-clients openssh-server && \
 yum clean all

# install libcurl 7.45.0
RUN mkdir -p /tmp/build/ && \
 cd /tmp/build && curl -L "http://curl.haxx.se/download/curl-7.45.0.tar.bz2" -o curl-7.45.0.tar.bz2 && \
 tar -xjf curl-7.45.0.tar.bz2 && cd curl-7.45.0 && \
 ./configure --prefix=/usr && make && make install && \
 rm -rf /tmp/build && ldconfig

RUN curl -L "http://repos.fedorapeople.org/repos/dchen/apache-maven/epel-apache-maven.repo" -o /etc/yum.repos.d/epel-apache-maven.repo && \
 yum install -y apache-maven && \
 yum clean all

# setup ssh server and keys for root
RUN ssh-keygen -t rsa -N "" -f ~/.ssh/id_rsa && \
 cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys && \
 chmod 0600 ~/.ssh/authorized_keys

# setup JAVA_HOME for all users
RUN echo "#!/bin/sh" > /etc/profile.d/java.sh && \
 echo "export JAVA_HOME=/etc/alternatives/java_sdk" >> /etc/profile.d/java.sh && \
 chmod a+x /etc/profile.d/java.sh

# install boost 1.59
RUN mkdir -p /tmp/build && \
 cd /tmp/build && curl -L "http://downloads.sourceforge.net/project/boost/boost/1.59.0/boost_1_59_0.tar.bz2" -o  boost_1_59_0.tar.bz2 && \
 tar -xjf boost_1_59_0.tar.bz2 && cd boost_1_59_0 && \
 ./bootstrap.sh && ./b2 --prefix=/usr -q && ./b2 --prefix=/usr -q install && \
 rm -rf /tmp/build

# install bison 2.5.1
RUN mkdir -p /tmp/build/ && \
 cd /tmp/build && curl -L "ftp://ftp.gnu.org/gnu/bison/bison-2.5.1.tar.gz" -o bison-2.5.1.tar.gz && \
 tar -xzf bison-2.5.1.tar.gz && cd bison-2.5.1 && \
 ./configure --prefix=/usr && make && make install && \
 rm -rf /tmp/build

# install thrift 0.9.2
RUN mkdir -p /tmp/build && \
 cd /tmp/build && curl -L "http://www.us.apache.org/dist/thrift/0.9.2/thrift-0.9.2.tar.gz" -o thrift-0.9.2.tar.gz && \
 tar -xzf thrift-0.9.2.tar.gz && cd thrift-0.9.2 && \
 ./configure --prefix=/usr \
	--with-cpp=yes --with-boost=yes --with-qt4=no --with-csharp=no --with-java=no --with-erlang=no --enable-tests=no \
	--with-nodejs=no --with-lua=no --with-python=no --with-perl=no --with-php=no && \
 make && make install && \
 rm -rf /tmp/build

# install protobuf 2.5.0
RUN mkdir -p /tmp/build/ && \
 cd /tmp/build && curl -L "https://github.com/google/protobuf/releases/download/v2.5.0/protobuf-2.5.0.tar.bz2" -o protobuf-2.5.0.tar.bz2 && \
 tar -xjf protobuf-2.5.0.tar.bz2 && cd protobuf-2.5.0 && \
 ./configure --prefix=/usr && make && make install && ldconfig && \
 rm -rf /tmp/build

# install libhdfs3
RUN mkdir -p /tmp/build && \
 cd /tmp/build && git clone https://github.com/PivotalRD/libhdfs3.git . && mkdir build && cd build && \
 ../bootstrap --prefix=/usr && make && make install && ldconfig && \
 rm -rf /tmp/build

# install python module 
RUN yum makecache && yum install -y postgresql-devel && \
 pip --retries=50 --timeout=300 install pg8000 simplejson unittest2 pycrypto pygresql pyyaml lockfile paramiko psi && \
 pip --retries=50 --timeout=300 install http://darcs.idyll.org/~t/projects/figleaf-0.6.1.tar.gz && \
 pip --retries=50 --timeout=300 install http://sourceforge.net/projects/pychecker/files/pychecker/0.8.19/pychecker-0.8.19.tar.gz/download && \
 yum erase -y postgresql postgresql-libs postgresql-devel && \
 yum clean all

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

