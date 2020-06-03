FROM library/centos:7

# install necessary packages
RUN yum -y update && yum install -y git tar bzr make gcc rsyslog \
rpm-build ruby-devel python curl

# install bats integration framework
RUN git clone https://github.com/sstephenson/bats.git && cd bats && ./install.sh /usr/local

# install fpm for packaging
RUN gem install --no-ri --no-rdoc fpm

WORKDIR /tmp/goldstone-server
ADD . /tmp/goldstone-server
