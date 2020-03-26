FROM registry.eng.hortonworks.com/hortonworks/base-centos7.6:0.1.0.0-88

ARG SALT_VERSION
ARG SALT_PATH
ARG PYZMQ_VERSION
ARG PYTHON_APT_VERSION
ARG TRACE
ARG OS
ARG OS_TYPE

ENV SYSTEMCTL_REPLACEMENT=https://raw.githubusercontent.com/hortonworks/docker-systemctl-replacement/3a885817b377f0307bd03d82323fa5749136de8f/files/docker/systemctl.py

#################################################################################
# Install Cloudbreak dependencies
#################################################################################
# Use docker-systemctl-replacement during SaltStack provisioning:
# `systemctl start xyz` commands are executed during highstate, which is not supported
# by systemd. docker-systemctl-replacement overcomes this limitation.

# Need to explicitly call yum update before linking systemctl-replacement to avoid
# the later update (executed through Salt recipe) overwriting our fix.
# RUN yum -y update



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

ADD ${SYSTEMCTL_REPLACEMENT} /usr/bin
RUN chmod 755 /usr/bin/$(basename ${SYSTEMCTL_REPLACEMENT}) && \
    mv /usr/bin/systemctl /usr/bin/systemctl.orig && \
    ln -sf /usr/bin/systemctl.py /usr/bin/systemctl

RUN /tmp/saltstack/salt-setup.sh hortonworks
RUN rm -f /etc/salt/minion_id /etc/salt/pki/minion/minion.pem /etc/salt/pki/minion/minion.pub

# restore systemctl to system default
RUN ln -sf /usr/bin/systemctl.orig /usr/bin/systemctl

ADD docker/centos7.6/image-runtime-scripts/start-services-script.sh /bootstrap/

#################################################################################

VOLUME [ "/sys/fs/cgroup" ]

ENTRYPOINT ["/bootstrap/start-systemd"]
CMD []
