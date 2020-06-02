FROM mgoldboi/ovirt-rpm:latest
MAINTAINER "Moran Goldboim" <mgoldboi@redhat.com>
ENV container docker

RUN yum -y update; yum -y install ovirt-hosted-engine-setup; yum clean all
ADD ovirt-engine-35-localdb.conf /tmp/ovirt-engine-35.conf
EXPOSE 5432
VOLUME [ "/var/lib/pgsql/data" ]
