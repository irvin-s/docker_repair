# Must be run as --privileged and --net=host
FROM centos:centos7
MAINTAINER Jose De la Rosa "https://github.com/jose-delarosa"

# Update and install required packages
RUN yum -y update
RUN yum -y install wget tar OpenIPMI usbutils perl

# Add repo
RUN wget -q -O - http://linux.dell.com/repo/hardware/latest/bootstrap.cgi | bash

# Install package
RUN yum -y install dcism

# Clean cache to reduce image size
RUN yum clean all

# The 'tailing' of the log file is so that we don't exit. Better way?
CMD /opt/dell/srvadmin/iSM/sbin/dsm_ism_srvmgrd && tail -f /var/log/yum.log
