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


# Add 10gen repository
ADD 10gen.repo /etc/yum.repos.d/10gen.repo

# Install MongoDB
RUN yum -y install mongo-10gen-server.x86_64 mongo-10gen.x86_64 --enablerepo=10gen

EXPOSE 27017

CMD ["/usr/bin/mongod", "--master", "--port", "27017", "--dbpath", "/var/lib/mongo"]
