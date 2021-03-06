# Copyright (c) 2015-2016 Tigera, Inc. All rights reserved.
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
ARG BIRD_IMAGE=calico/bird:latest

FROM calico/bpftool:v5.0-amd64 as bpftool
FROM ${BIRD_IMAGE} as bird

FROM debian:9.8-slim
LABEL maintainer "Casey Davenport <casey@tigera.io>"

ARG ARCH=amd64

# Install a backported version of iptables to ensure we have version 1.6.2
# Similarly for iproute2, we want a more recent version for BPF support.
RUN printf "deb http://deb.debian.org/debian stretch-backports main\n" > /etc/apt/sources.list.d/backports.list \ 
    && apt-get update \
    && apt-get -t stretch-backports install -y iptables iproute2

# Install remaining runtime deps required for felix from the global repository
RUN apt-get update && apt-get install -y \
    ipset \
    iputils-arping \
    iputils-ping \
    iputils-tracepath \
    # Need arp 
    net-tools \ 
    conntrack \ 
    runit \ 
    # Need kmod to ensure ip6tables-save works correctly
    kmod \ 
    # Need netbase in order for ipset to work correctly 
    # See https://github.com/kubernetes/kubernetes/issues/68703
    netbase \ 
    # Also needed (provides utilities for browsing procfs like ps) 
    procps \    
    ca-certificates

# Copy our bird binaries in
COPY --from=bird /bird* /bin/

# Copy in the filesystem - this contains felix, calico-bgp-daemon etc...
COPY filesystem/ /

# Add in confd config and templates
COPY vendor/github.com/kelseyhightower/confd/etc/calico/ /etc/calico/

# Copy in the calico-node binary
COPY dist/bin/calico-node-${ARCH} /bin/calico-node

COPY --from=bpftool /bpftool /bin

CMD ["start_runit"]
