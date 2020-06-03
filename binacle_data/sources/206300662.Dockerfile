FROM centos:centos7
MAINTAINER Kevin Klues <klueska@mesosphere.com>

RUN yum groupinstall -y 'Development Tools' && \
    yum clean all

RUN yum install -y sudo \
                   which \
                   wget \
                   git \
                   maven && \
    yum clean all

RUN  sed -i "s/Defaults    requiretty.*/ #Defaults    requiretty/g" \
            /etc/sudoers

RUN yum install -y java-1.8.0-openjdk-devel \
                   python-devel \
                   zlib-devel \
                   libcurl-devel \
                   openssl-devel \
                   cyrus-sasl-devel \
                   cyrus-sasl-md5 \
                   apr-devel \
                   apr-utils-devel \
                   subversion-devel \
                   libevent-devel \
                   libev-devel && \
    yum clean all

RUN git clone https://github.com/apache/mesos.git

WORKDIR /mesos
