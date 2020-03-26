FROM centos:7.4.1708
MAINTAINER feedforce Inc.

# setup
RUN yum install -y rpm-build tar make

# ruby depends
RUN yum -y install readline-devel ncurses-devel gdbm-devel glibc-devel gcc openssl-devel libyaml-devel libffi-devel zlib-devel

# rpmbuild command recommends to use `builder:builder` as user:group.
RUN useradd -u 1000 builder

RUN mkdir -p /home/builder/rpmbuild/{BUILD,BUILDROOT,RPMS,SOURCES,SPECS,SRPMS}
RUN chown -R builder:builder /home/builder/rpmbuild

WORKDIR /home/builder/rpmbuild
