#################################################
# Hostpadapd-WPE Edition w/Radius Backend - Docker Script v.1
# Author: Viet Luu (Mr.V) at www.ring0labs.com
#################################################

# Use Kali Linux Base Image Official

FROM kalilinux/kali-linux-docker

MAINTAINER Viet Luu

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update -y

# Install prerequisites

RUN apt-get install -y \
	dnsmasq \
	patch \
	make \
	gcc \
	libnl-3-dev \
	libnl-genl-3-dev\
	libssl1.0-dev

# Use baseimage-docker's init system

CMD ["/sbin/my_init"]

# Install HOSTAPD-WPE

ADD tools/hostapd-2.2.tar.gz /opt/
RUN cd /opt/hostapd-2.2/hostapd/ && make

#create symbolic link

RUN ln -s /opt/hostapd-2.2/hostapd/hostapd-wpe /usr/sbin/hostapd-wpe
