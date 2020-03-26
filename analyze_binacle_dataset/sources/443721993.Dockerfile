FROM centos:centos6
MAINTAINER Chef Software, Inc <docker@getchef.com>
RUN yum clean all
RUN yum install -y curl
RUN curl -L https://getchef.com/chef/install.sh | bash -s -- -v <%= version %> -P container
