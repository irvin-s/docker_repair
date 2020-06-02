## -*- docker-image-name: "scaleway/openvpn:latest" -*-
ARG SCW_ARCH

FROM scaleway/ubuntu:${SCW_ARCH}-xenial


MAINTAINER Scaleway <opensource@scaleway.com> (@scaleway)


# Prepare rootfs for image-builder
RUN /usr/local/sbin/scw-builder-enter


# Install packages
RUN apt-get -q update        \
 && apt-get install -y -q    \
 	easy-rsa             \
	curl                 \
	iptables             \
	openvpn              \
	uuid                 \
	unbound              \
 && apt-get clean

# Patch rootfs
COPY ./overlay/ /

# Clean rootfs from image-builder
RUN /usr/local/sbin/scw-builder-leave
