# check_openmanage plugin for Nagios (Nagios not installed)
FROM centos:centos7
MAINTAINER Jose De la Rosa "https://github.com/jose-delarosa"

# Environment variables
ENV EPEL https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
ENV VERSION check_openmanage-3.7.12
ENV URL http://folk.uio.no/trondham/software/files/$VERSION.tar.gz
ENV PATH $PATH:$VERSION

# Do overall update and install missing packages needed
RUN yum -y install $EPEL; yum -y install wget tar perl perl-Net-SNMP; \
    yum clean all

# Download package
RUN wget $URL; tar zxvf $VERSION.tar.gz

CMD ["/bin/bash"]
