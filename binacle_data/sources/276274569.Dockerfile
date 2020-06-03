FROM ubuntu:xenial

RUN apt-get update && \
    apt-get install -y git make openssl libcrypto++-dev libnuma-dev && \
    apt-get autoclean

RUN git clone https://gerrit.fd.io/r/vpp -b stable/1710 /root/vpp-1710

WORKDIR /root/vpp-1710
COPY ./0001-net-virtio-ethdev.patch dpdk/dpdk-17.08_patches/0001-net-virtio-ethdev.patch
RUN sed -i "s/sudo -E //g" Makefile
RUN make UNATTENDED=yes install-dep

WORKDIR /root/vpp-1710/build-root
RUN ./bootstrap.sh
RUN make PLATFORM=vpp TAG=vpp_debug vpp-install
RUN mkdir -p /etc/vpp && \
    cp /root/vpp-1710/src/vpp/conf/startup.conf /etc/vpp/startup.conf && \
    cp /root/vpp-1710/build-root/install-vpp_debug-native/vpp/bin/* /usr/bin && \
    ln -s /root/vpp-1710/build-root/install-vpp_debug-native/vpp/lib64/vpp_plugins /usr/lib/vpp_plugins
RUN groupadd vpp

ENV PATH "$PATH:/root/vpp-1710/build-root/install-vpp_debug-native/dpdk/bin"
ENV PATH "$PATH:/root/vpp-1710/build-root/install-vpp_debug-native/vpp/bin"
