FROM centos:centos7

RUN yum -y install golang; yum -y clean all
RUN yum -y install git; yum -y clean all
RUN yum -y install bzr; yum -y clean all
RUN yum -y install mercurial; yum -y clean all
