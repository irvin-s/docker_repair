##
## hepsw/cc7-base is a WIP image for CERN CentOS-7
##
FROM centos:7
MAINTAINER Sebastien Binet "binet@cern.ch"

# add CERN CentOS yum repo
ADD http://linux.web.cern.ch/linux/centos7/CentOS-CERN.repo /etc/yum.repos.d/CentOS-CERN.repo
ADD http://linuxsoft.cern.ch/cern/centos/7/os/x86_64/RPM-GPG-KEY-cern /tmp/RPM-GPG-KEY-cern

RUN /usr/bin/rpm --import /tmp/RPM-GPG-KEY-cern && \
    /bin/rm /tmp/RPM-GPG-KEY-cern

# RUN /usr/bin/yum groups mark convert && \
#     /usr/bin/yum --enablerepo=*-testing clean all && \
#     /usr/bin/yum groupinstall --skip-broken -y 'CERN Base Tools' && \
#     /usr/bin/yum groupinstall --skip-broken -y --exclude libwbclient.i686 'Software Development Workstation (CERN Recommended Setup)' && \
#     /usr/bin/yum --enablerepo=*-testing clean all

RUN yum update -y && \
	yum clean all && \
	/bin/rm -rf /var/cache/yum

## EOF
