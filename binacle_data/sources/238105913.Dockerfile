FROM centos:latest

RUN yum install -y https://github.com/minio/minfs/releases/download/RELEASE.2016-10-04T19-44-43Z/minfs-0.0.20161004194443-1.x86_64.rpm \
    && yum clean all
