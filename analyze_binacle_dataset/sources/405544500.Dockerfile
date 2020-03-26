# base centos
FROM centos:7

# maintainer
MAINTAINER Peter Xu <peter@uskee.org>

# environments
COPY centos/CentOS-Base.repo /etc/yum.repos.d/CentOS-Base.repo
COPY centos/epel.repo /etc/yum.repos.d/epel.repo
COPY centos/docker-ce.repo /etc/yum.repos.d/docker-ce.repo

# install base
RUN yum install -y libuuid libffi
RUN yum install -y glib2 openssl gnutls
RUN yum install -y net-tools
RUN yum install -y openssl-devel gnutls-devel
RUN yum install -y glib2-devel
#RUN yum clean all

# install golang
RUN yum install -y golang
RUN yum clean all

ADD lib/ /usr/local/lib/
ADD include/ /usr/local/include/

ADD entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
CMD ["sleep", "30"]
