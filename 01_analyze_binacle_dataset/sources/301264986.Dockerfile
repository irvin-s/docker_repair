# =============================================================================
# index.tenxcloud.com/jimmy/centos:7.2.1511
#
# CentOS-7 7.2.1511 x86_64 - Supervisor
# 
# =============================================================================
FROM centos:7.2.1511

MAINTAINER Jimmy Song <rootsongjc@gmail.com>

# -----------------------------------------------------------------------------
# Import the Repositories
# -----------------------------------------------------------------------------
RUN rm -f /etc/yum.repos.d/*
ADD etc/yum.repos.d/td-idc-yz.repo /etc/yum.repos.d/

# -----------------------------------------------------------------------------
# Base Install
# -----------------------------------------------------------------------------
RUN rpm --rebuilddb \
	&& yum -y install \
		vim \
        tar \
        net-tools \
		xz-5.1.2-12alpha.el7.x86_64 \
		python-setuptools-0.9.8-4.el7 \
		yum-plugin-versionlock-1.1.31-34.el7 \
	&& yum versionlock add \
		vim \
		xz \
        tar \
		python-setuptools \
		yum-plugin-versionlock \
	&& rm -rf /var/cache/yum/* \
	&& yum clean all

# -----------------------------------------------------------------------------
# Install supervisord (required to run more than a single process in a container)
# Note: EPEL package lacks /usr/bin/pidproxy
# We require supervisor-stdout to allow output of services started by 
# supervisord to be easily inspected with "docker logs".
# -----------------------------------------------------------------------------
RUN easy_install \
		'supervisor == 3.3.1' \
		'supervisor-stdout == 0.1.1' \
	&& mkdir -p \
		/var/log/supervisor/

# -----------------------------------------------------------------------------
# CTC Timezone & Networking
# -----------------------------------------------------------------------------
RUN ln -sf \
		/usr/share/zoneinfo/Asia/Shanghai \
		/etc/localtime \
	&& echo "NETWORKING=yes" > /etc/sysconfig/network

# -----------------------------------------------------------------------------
# Copy files into place
# -----------------------------------------------------------------------------
RUN mkdir -p \
		/etc/supervisord.d/ 

ADD etc/services-config/supervisor/supervisord.conf \
	/etc/
ADD etc/services-config/supervisor/supervisord.d \
	/etc/supervisord.d/

# -----------------------------------------------------------------------------
# Purge
# -----------------------------------------------------------------------------
RUN rm -rf /etc/ld.so.cache \
	; rm -rf /sbin/sln \
	; rm -rf /usr/{{lib,share}/locale,share/{man,doc,info,cracklib,i18n},{lib,lib64}/gconv,bin/localedef,sbin/build-locale-archive} \
	; rm -rf /{root,tmp,var/cache/{ldconfig,yum}}/* \
	; > /etc/sysconfig/i18n

# -----------------------------------------------------------------------------
# Ulimit
RUN echo "* soft nofile 655350" >> /etc/security/limits.conf & \
echo "* hard nofile 655350" >> /etc/security/limits.conf & \
echo "@root        soft    nproc           655350" >> /etc/security/limits.conf & \
echo "@root        hard    nproc           655350" >> /etc/security/limits.conf & \
echo "ulimit -SH 655350" >> /etc/rc.local
# -----------------------------------------------------------------------------

# -----------------------------------------------------------------------------
# Set default environment variables
# -----------------------------------------------------------------------------

# -----------------------------------------------------------------------------
# Set image metadata
# -----------------------------------------------------------------------------
ARG RELEASE_VERSION="1.0.0"
LABEL \
        description="CentOS-7 7.2.1511 x86_64 - Supervisor /" \
        vendor="CentOS"

CMD ["/usr/bin/supervisord", "--configuration=/etc/supervisord.conf"]
