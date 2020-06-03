FROM centos:7.2.1511  
MAINTAINER Daniel Falkner <dafalkne@microsoft.com>  
COPY bootstrap.sh /tmp/bootstrap.sh  
RUN yum -y install wget  
RUN sh /tmp/bootstrap.sh

