#
# Dockerfile_afi_vmx
# Build docker container where VMX can also be run along with AFI client
#
# Advanced Forwarding Interface : AFI client examples
#
# Created by Sandesh Kumar Sodhi, January 2017
# Copyright (c) [2017] Juniper Networks, Inc. All rights reserved.
#
# All rights reserved.
#
# Notice and Disclaimer: This code is licensed to you under the Apache
# License 2.0 (the "License"). You may not use this code except in compliance
# with the License. This code is not an official Juniper product. You can
# obtain a copy of the License at http://www.apache.org/licenses/LICENSE-2.0
#
# Third-Party Code: This code may depend on other components under separate
# copyright notice and license terms. Your use of the source code for those
# components is subject to the terms and conditions of the respective license
# as noted in the Third-Party source code file.
#

FROM afi-docker
LABEL maintainer "Sandesh Kumar Sodhi"

ARG VMX_BUNDLE
#
# Build
#  Copy VMX bundle image to current directory and then build container using following command
#  docker build -f Dockerfile_afi_vmx --build-arg VMX_BUNDLE=<vmx bundle image> -t afi-vmx-docker .
#  E.g.
#  docker build -f Dockerfile_afi_vmx --build-arg VMX_BUNDLE=vmx-bundle.tgz -t afi-vmx-docker .
#
# Run:
#  docker run --name afi-vmx --privileged -i -t afi-vmx-docker /bin/bash
#

#
# Packages needed for VMX
#
RUN apt-get update && apt-get install -y --no-install-recommends \
 apparmor \
 apparmor-utils \
 apparmor-profiles \
 qemu-kvm \
 libvirt-bin \
 python \
 python-netifaces \
 vnc4server \
 libyaml-dev \
 python-yaml \
 numactl \
 libparted0-dev \
 libpciaccess-dev \
 libnuma-dev \
 libyajl-dev \
 libxml2-dev \
 libglib2.0-dev \
 libnl-dev \
 python-pip \
 python-dev \
 libxml2-dev \
 libxslt-dev

#
# Steps needed to run VMX successfully
#
RUN cp /etc/libvirt/qemu.conf /etc/libvirt/qemu.conf.orig
RUN sed -i -e 's/#user = "root"/user = "root"/g' /etc/libvirt/qemu.conf
RUN sed -i -e 's/#group = "root"/group = "kvm"/g' /etc/libvirt/qemu.conf
#
#diff qemu.conf.orig qemu.conf
#229c229
#< #user = "root"
#---
#> user = "root"
#233c233
#< #group = "root"
#---
#> group = "kvm"


COPY scripts  /root/scripts
COPY cfg      /root/cfg

#
# Copy VMX image now
#
RUN echo $VMX_BUNDLE
ENV  VMX_BUNDLE_IMAGE $VMX_BUNDLE
COPY $VMX_BUNDLE /root/$VMX_BUNDLE_IMAGE


COPY entrypoint.sh /root/entrypoint.sh

ENTRYPOINT ["/root/entrypoint.sh"]
