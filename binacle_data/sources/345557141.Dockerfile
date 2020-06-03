# Must be run as --privileged, with --net=host and volume mount /var/log
FROM centos:centos7
MAINTAINER Jose De la Rosa "https://github.com/jose-delarosa"
# ENV http_proxy http://dlr.linuxdev.us.dell.com:5865
# ENV https_proxy http://dlr.linuxdev.us.dell.com:5865
# ENV no_proxy linux.dell.com

# Because of packaging quirks, have to be specific on package versions used
ENV DSU_VERS DSU_16.04.00
ENV ISM_VERS Y2NTV_LN64_2.3.0_A00

# Update and install required packages
RUN yum -y update && \
    yum -y install wget tar OpenIPMI usbutils perl which less net-tools

# Add repo
RUN wget -q -O - http://linux.dell.com/repo/hardware/${DSU_VERS}/bootstrap.cgi | bash

# Install package
RUN yum -y install Systems-Management_Application_${ISM_VERS}

# Extract DUP and install RHEL 7 RPM
RUN cd /usr/libexec/dell_dup/; \
    ./Systems-Management_Application_${ISM_VERS}.BIN --extract files; \
    cd files; \
    yum -y localinstall dcism-2.3.0-223.el7.x86_64.rpm && yum clean all

# dsm_ism_srvmgrd runs in the background, so let's tail an arbitrary file so
# that we stay in the foreground.
CMD /opt/dell/srvadmin/iSM/sbin/dsm_ism_srvmgrd && tail -f /etc/hostname
