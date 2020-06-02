FROM centos:centos7

RUN rpm --import http://epel.mirrors.ovh.net/epel/RPM-GPG-KEY-EPEL-7
RUN rpm -Uvh http://epel.mirrors.ovh.net/epel/7/x86_64/e/epel-release-7-8.noarch.rpm

RUN yum update -y
RUN yum install -y gflags protobuf libmicrohttpd subversion-libs

ADD scheduler/quobyte-mesos /opt/quobyte-mesos
# COPY executor/executor.tar.gz /opt/executor/executor.tar.gz
COPY executor/quobyte-mesos-executor /opt/quobyte-mesos-executor
ADD thirdparty/mesos/src/.libs/libmesos-*.so /opt/
ADD quobyte-mesos-cmd.sh /opt/quobyte-mesos-cmd.sh

CMD ["/opt/quobyte-mesos-cmd.sh"]
