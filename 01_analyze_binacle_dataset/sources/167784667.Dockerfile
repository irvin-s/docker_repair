FROM mgoldboi/ovirt-35-clean:latest
MAINTAINER "Moran Goldboim" <mgoldboi@redhat.com>
ENV container docker

#yum updates and needed RPMs
RUN yum -y update; \
yum -y ovirt-engine-reports; \
yum clean all;
