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

# Install Memcached
RUN yum -y install memcached

EXPOSE 11211

CMD ["/usr/bin/memcached", "-u", "memcached", "-m", "128", "-p", "11211", "-c", "1024"]
