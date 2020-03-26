# Version 1.0.0

FROM centos

MAINTAINER wasabeef <dadadada.chop@gmail.com>

# Epel
RUN rpm -Uvh http://download.fedoraproject.org/pub/epel/6/i386/epel-release-6-8.noarch.rpm

# Install Development Tools
RUN yum -y groupinstall "Development Tools"

# yum update
RUN yum -y update
RUN yum clean all

# Install Redis
RUN yum -y install redis

EXPOSE 6379

CMD ["/usr/sbin/redis-server"]
