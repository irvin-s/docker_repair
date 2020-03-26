FROM ubuntu:12.04
MAINTAINER Chef Software, Inc <docker@getchef.com>
RUN apt-get -yqq update
RUN apt-get -yqq install curl lsb-release
RUN curl -L https://getchef.com/chef/install.sh | bash -s -- -v <%= version %> -P container
