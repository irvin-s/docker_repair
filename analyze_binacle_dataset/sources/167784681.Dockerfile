FROM mgoldboi/ovirt-3.5.0-rpm
MAINTAINER "Moran Goldboim" <mgoldboi@redhat.com>
ENV container docker

RUN yum -y update; yum clean all
ADD ovirt-engine-35-remotedb.conf /tmp/ovirt-engine-35.conf
