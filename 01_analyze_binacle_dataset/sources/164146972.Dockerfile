FROM centos:centos7
MAINTAINER Przemyslaw Ozgo <linux@ozgo.info>

RUN \
    yum update -y && \
    yum install -y net-snmp net-snmp-utils && \
    yum clean all

COPY container-files /

EXPOSE 161

ENTRYPOINT ["/bootstrap.sh"]