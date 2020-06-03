FROM centos

RUN yum update -y && yum install -y ruby-devel gcc make rpm-build

RUN gem install fpm

ADD ./entrypoint.sh /entrypoint.sh

ENTRYPOINT /entrypoint.sh