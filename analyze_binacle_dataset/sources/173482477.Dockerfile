FROM docker.io/centos:7.3.1611

ARG SALT_VERSION
ARG SALT_PATH
ARG PYZMQ_VERSION
ARG PYTHON_APT_VERSION
ARG TRACE
ARG OS
ARG OS_TYPE

LABEL maintainer=Hortonworks

ENV container docker
ENV TERM linux
ENV PS1 "[\u@cloudbreak \W]\$ "

ENV SYSTEMCTL_REPLACEMENT=https://raw.githubusercontent.com/hortonworks/docker-systemctl-replacement/3a885817b377f0307bd03d82323fa5749136de8f/files/docker/systemctl.py

# Fix the default shell from dash to bash
# Do it one line. Otherwise, after doing rm, docker build cannot find a shell to
# run more RUN commands :)
RUN bash -c 'rm /bin/sh; ln -s /bin/bash /bin/sh'
RUN chsh -s /bin/bash

#################################################################################
# Systemd stuff
#################################################################################
RUN (cd /lib/systemd/system/sysinit.target.wants/; for i in *; do [ $i == systemd-tmpfiles-setup.service ] || rm -f $i; done); \
    rm -f /lib/systemd/system/multi-user.target.wants/*;\
    rm -f /etc/systemd/system/*.wants/*;\
    rm -f /lib/systemd/system/local-fs.target.wants/*; \
    rm -f /lib/systemd/system/sockets.target.wants/*udev*; \
    rm -f /lib/systemd/system/sockets.target.wants/*initctl*; \
    rm -f /lib/systemd/system/basic.target.wants/*;\
    rm -f /lib/systemd/system/anaconda.target.wants/*;
#################################################################################

#################################################################################
# Setup yum repos
#################################################################################

# XXX: Disabled for public build
# Disable fast-mirrors plugin and force everything through our internal repo
#RUN sed -i -e 's/^enabled=1/enabled=0/g' /etc/yum/pluginconf.d/fastestmirror.conf

# Install epel repo files. epel-release has to go first before some of the other
# packages can be installed
RUN yum -y install epel-release

# XXX: Disabled for public build
# BUG-68936 Fixing the image to use the HWX internal repos to avoid massive
# downloads due to cache-misses on the internal caching-proxy.
#RUN rm -rf /etc/yum.repos.d/*
#COPY files/hwx-internal.repo /etc/yum.repos.d/

# Give preference to our repos
RUN yum -y install yum-priorities
#################################################################################

#################################################################################
# Install basic OS packages + GCC (to build bootstrap)
#################################################################################
RUN yum install -y yum-utils yum-plugin-ovl tar git curl bind-utils \
                   unzip wget gcc net-tools sudo zip lsof strace redhat-lsb

RUN yum install -y openssh-server openssh-clients
RUN systemctl enable sshd

RUN mkdir -p /tmp/image-build-space/image-prep-scripts

#################################################################################
# Setup access
#################################################################################
RUN mkdir -p /tmp/image-build-space/access

COPY docker/centos7.3/files/access/* /tmp/image-build-space/access/

COPY docker/centos7.3/files/pam/* /tmp/image-build-space/access/

COPY docker/centos7.3/files/image-prep-scripts/setup-access.sh /tmp/image-build-space/image-prep-scripts
RUN /tmp/image-build-space/image-prep-scripts/setup-access.sh

COPY docker/centos7.3/files/image-prep-scripts/hwx-internal-setup.sh /tmp/image-build-space/image-prep-scripts
RUN /tmp/image-build-space/image-prep-scripts/hwx-internal-setup.sh
#################################################################################

# install iproute explicitly on centos7, it's present by default in centos6, debian7
RUN yum -y install iproute

#################################################################################
# Setup access
#################################################################################
RUN mkdir -p /bootstrap /bootstrap/logs

COPY docker/centos7.3/files/image-prep-scripts/privileged-start-services-script.c /tmp/image-build-space/image-prep-scripts/

RUN gcc /tmp/image-build-space/image-prep-scripts/privileged-start-services-script.c -D COMMAND=\"/bootstrap/start-services-script.sh\" -o /bootstrap/start-systemd
RUN chgrp -v nobody /bootstrap/start-systemd
RUN chmod 4050 /bootstrap/start-systemd

ADD docker/centos7.3/files/image-runtime-scripts/start-services-script.sh /bootstrap/

#################################################################################
# Operating system specific stuff
#################################################################################
COPY docker/centos7.3/files/base-centos7.3-os-specific-build.sh /tmp/image-build-space/
RUN /tmp/image-build-space/base-centos7.3-os-specific-build.sh

# Get rid "Unable to get valid context .." message
COPY docker/centos7.3/files/autorelabel /.autorelabel

#################################################################################
# Install Cloudbreak dependencies
#################################################################################
# Use docker-systemctl-replacement during SaltStack provisioning:
# `systemctl start xyz` commands are executed during highstate, which is not supported
# by systemd. docker-systemctl-replacement overcomes this limitation.

# Need to explicitly call yum update before linking systemctl-replacement to avoid
# the later update (executed through Salt recipe) overwriting our fix.
RUN yum -y update
ADD ${SYSTEMCTL_REPLACEMENT} /usr/bin
RUN chmod 755 /usr/bin/$(basename ${SYSTEMCTL_REPLACEMENT}) && \
    mv /usr/bin/systemctl /usr/bin/systemctl.orig && \
    ln -sf /usr/bin/systemctl.py /usr/bin/systemctl

COPY /saltstack /tmp/saltstack
COPY /repos /tmp/repos
COPY /scripts/salt-install.sh /tmp/saltstack/
COPY /scripts/salt-setup.sh /tmp/saltstack/
COPY /scripts/salt_requirements.txt /tmp/salt_requirements.txt

# Workaround problem caused by sytemd not being pid-1:
# Force the minions to use systemd on this host
RUN echo $'\n\
providers:\n\
  service: systemd\n'\
>>  /tmp/saltstack/config/minion

COPY docker/common/_grains/ /tmp/saltstack/base/salt/_grains/
COPY docker/common/_grains/ /tmp/saltstack/hortonworks/salt/_grains/

RUN /tmp/saltstack/salt-install.sh centos ${SALT_REPO}
RUN /tmp/saltstack/salt-setup.sh hortonworks
RUN rm -f /etc/salt/minion_id /etc/salt/pki/minion/minion.pem /etc/salt/pki/minion/minion.pub

# Fix issue of `systemctl start xyz` yields 'Failed to get D-Bus connection: Operation not permitted' error
COPY docker/centos7.3/files/workaround_systemd_start.service /usr/lib/systemd/system/workaround_systemd_start.service
RUN systemctl enable workaround_systemd_start

# restore systemctl to system default
RUN ln -sf /usr/bin/systemctl.orig /usr/bin/systemctl
#################################################################################

VOLUME [ "/sys/fs/cgroup" ]

CMD ["/bootstrap/start-systemd"]
