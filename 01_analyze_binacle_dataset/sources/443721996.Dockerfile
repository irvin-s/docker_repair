FROM debian:wheezy
MAINTAINER Chef Software, Inc <docker@getchef.com>
RUN apt-get -y update
RUN apt-get -y install curl
RUN curl -L https://getchef.com/chef/install.sh | bash -s -- -v <%= version %> -P container
