FROM centos:7

RUN yum -y update \
	&& yum install -y python27 sqlite-devel rpm-build rpmdevtools

VOLUME /build
