FROM centos:6
MAINTAINER Alan Franzoni username@franzoni.eu
# should be unneeded, but let's stay sure. fixes issues with docker and overlayfs
RUN touch /var/lib/rpm/* && yum install -y yum-plugin-ovl
ADD files/etc/yum.conf /etc/
RUN sed -i.original -e 's/^/#/' /etc/yum.repos.d/*.repo
ADD files/etc/rpm/macros.drb /etc/rpm/macros.drb
ADD files/tmp /tmp
RUN rpm --import /tmp/*.pub
RUN yum clean metadata
RUN yum install yum-presto
RUN yum update
RUN yum install @Base @buildsys-build yum-utils
RUN sed -i.original -e 's/^/#/' /etc/yum.repos.d/epel*.repo
