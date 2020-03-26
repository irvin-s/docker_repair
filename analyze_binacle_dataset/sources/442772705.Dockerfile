FROM centos:7
MAINTAINER Alan Franzoni username@franzoni.eu
# should be unneeded on recent centos:7 images, but let's make sure this 
# is always installed or the image won't work on overlayfs driver
RUN touch /var/lib/rpm/* && yum install -y yum-plugin-ovl
ADD files/etc/yum.conf /etc/
RUN sed -i.original -e 's/^/#/' /etc/yum.repos.d/*.repo
ADD files/etc/rpm/macros.drb /etc/rpm/macros.drb
ADD files/tmp /tmp
RUN rpm --import  /tmp/fd431d51.txt /tmp/RPM-GPG-KEY-CentOS-7 /tmp/RPM-GPG-KEY-EPEL-7
RUN yum install deltarpm
RUN yum clean metadata
RUN yum update
RUN yum install @buildsys-build yum-utils rpm-sign sudo
RUN sed -i.original -e 's/^/#/' /etc/yum.repos.d/epel*.repo
RUN yum clean metadata
