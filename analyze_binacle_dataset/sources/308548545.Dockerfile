# Copyright 2018 JinkIT LLC, v1k0d3n, and its Authors.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
FROM ubuntu:16.04
MAINTAINER bjozsa@jinkit.com

# Set buildtime ARGs:
ARG DEBIAN_FRONTED=noninteractive
ARG ARCH="amd64"
ARG VERSION_CNI="v0.6.0"
ARG VERSION_DOCK="17.03.2"
ARG VERSION_HELM="v2.7.2"
ARG VERSION_KUBEADM="v1.9.3"
ARG VERSION_KUBECTL="v1.9.3"
ARG VERSION_KUBELET="v1.9.3"
ARG BOOTSTR_CONF="/root/etc/kubeadm-conf.yaml"
ARG ROOTFS=${ROOTFS:-kubeadm}

# Set container ENVs from ARGs:
ENV ARCH=${ARCH} \
    VERSION_CNI=${VERSION_CNI} \
    VERSION_DOCK=${VERSION_DOCK} \
    VERSION_HELM=${VERSION_HELM} \
    VERSION_KUBEADM=${VERSION_KUBEADM} \
    VERSION_KUBECTL=${VERSION_KUBECTL} \
    VERSION_KUBELET=${VERSION_KUBELET} \
    BOOTSTR_CONF=${BOOTSTR_CONF} \
    ROOTFS=${ROOTFS} \
    DEBIAN_FRONTEND="noninteractive" \
    DIR_BIN_CNI="/opt/cni/bin"

ENV container docker
STOPSIGNAL SIGRTMIN+3

# Set variables from ARGS for reuse later:
RUN set | grep VERSION_ > /.kubeadm.env ;\
    set | grep BOOTSTR_ >> /.kubeadm.env ;\
    set | grep ROOTFS >> /.kubeadm.env

# We don't need no graphical.target here:
RUN systemctl set-default multi-user.target

# Create various directories:
RUN mkdir -p /opt/${ROOTFS} ;\
    mkdir -p ${ROOTFS}

# Add files to container during build process:
COPY bin /${ROOTFS}/bin
COPY etc /${ROOTFS}/etc

# Update/upgrade sources/packages:
RUN apt-get update ;\
    apt-get upgrade -y

# Install prereqs:
RUN apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    software-properties-common

# Add gpg keys for custom any repos:
RUN curl -s https://download.docker.com/linux/ubuntu/gpg | apt-key add - ;\
    curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -

# Add the custom repos to apt sources:
RUN chmod +x /${ROOTFS}/bin/repo
RUN /${ROOTFS}/bin/repo

# Update with new sources/repos:
RUN apt-get update

# Install packages from those sources:
RUN apt-get install -y \
    docker-ce=${VERSION_DOCK}~ce-0~ubuntu-xenial \
    ebtables \
    ethtool \
    kmod \
    kubernetes-cni \
    libwrap0 \
    systemd \
    tcpd

# Install libgcrypt11 for CentOS support:
RUN curl -o /tmp/libgcrypt11_1.5.3.deb -L https://launchpad.net/~ubuntu-security/+archive/ubuntu/ppa/+build/8993248/+files/libgcrypt11_1.5.3-2ubuntu4.3_amd64.deb ;\
    dpkg -i /tmp/libgcrypt11_1.5.3.deb ;\
    apt-get install -f

# Separately install any kubeadm requirements:
RUN apt-get install -y \
    socat

# Clean up apt-cache:
RUN apt-get clean ;\
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Download - kubeadm:
RUN curl -o /${ROOTFS}/bin/kubeadm https://storage.googleapis.com/kubernetes-release/release/${VERSION_KUBEADM}/bin/linux/${ARCH}/kubeadm ;\
    chmod +x /${ROOTFS}/bin/kubeadm

# Download - kubectl:
RUN curl -o /${ROOTFS}/bin/kubectl https://storage.googleapis.com/kubernetes-release/release/${VERSION_KUBEADM}/bin/linux/${ARCH}/kubectl ;\
    chmod +x /${ROOTFS}/bin/kubectl

# Download - kubelet:
RUN curl -o /${ROOTFS}/bin/kubelet https://storage.googleapis.com/kubernetes-release/release/${VERSION_KUBEADM}/bin/linux/${ARCH}/kubelet ;\
    chmod +x /${ROOTFS}/bin/kubelet

# Download - cni:
RUN mkdir /${ROOTFS}/cni ;\
    curl -o /${ROOTFS}/cni-${ARCH}-${VERSION_CNI}.tgz https://github.com/containernetworking/cni/releases/download/${VERSION_CNI}/cni-${ARCH}-${VERSION_CNI}.tgz --location ;\
    curl -o /${ROOTFS}/cni-plugins-${ARCH}-${VERSION_CNI}.tgz https://github.com/containernetworking/plugins/releases/download/${VERSION_CNI}/cni-plugins-${ARCH}-${VERSION_CNI}.tgz --location ;\
    tar -zxvf /${ROOTFS}/cni-${ARCH}-${VERSION_CNI}.tgz -C /${ROOTFS}/cni/ ;\
    tar -zxvf /${ROOTFS}/cni-plugins-${ARCH}-${VERSION_CNI}.tgz -C /${ROOTFS}/cni/ ;\
    rm -rf /${ROOTFS}/cni-*

# Set PATH inside of the container:
ENV PATH="/${ROOTFS}/bin/app:/opt/${ROOTFS}/bin/app:/opt/${ROOTFS}/bin:${PATH}"

# Clean directories to read host systemd:
RUN cd /lib/systemd/system/sysinit.target.wants/; ls | grep -v systemd-tmpfiles-setup | xargs rm -f $1 \
    rm -f /lib/systemd/system/multi-user.target.wants/*;\
    rm -f /etc/systemd/system/*.wants/*;\
    rm -f /lib/systemd/system/local-fs.target.wants/*; \
    rm -f /lib/systemd/system/sockets.target.wants/*udev*; \
    rm -f /lib/systemd/system/sockets.target.wants/*initctl*; \
    rm -f /lib/systemd/system/basic.target.wants/*;\
    rm -f /lib/systemd/system/anaconda.target.wants/*; \
    rm -f /lib/systemd/system/plymouth*; \
    rm -f /lib/systemd/system/systemd-update-utmp*;

# Well, we are trying to access systemd from here:
RUN systemctl set-default multi-user.target
ENV init /lib/systemd/systemd

# WORKDIR "/opt/${ROOTFS}/etc/kubeadm/"
# VOLUME ["/opt/${ROOTFS}"]

# Final entrypoint for the container:
#CMD ["kubeadm", "init", "--config=config.yaml"]
COPY gantry /usr/local/bin/gantry
#WORKDIR /opt/${ROOTFS}/etc/kubeadm/
CMD ["gantry"]
