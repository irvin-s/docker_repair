##Base dockerfile for Quagga routers
# BASIC template taken from ubuntu image w/networking tools 
# @ https://community.gns3.com/community/connect/community-blog/blog/2015/06/09/running-quagga-container-with-gns3
# Emmanuel Shiferaw
# Davis Gossage

# Use phusion/baseimage as base image. To make your builds
# reproducible, make sure you lock down to a specific version, not
# to `latest`! See
# https://github.com/phusion/baseimage-docker/blob/master/Changelog.md
# for a list of version numbers.
FROM phusion/baseimage:0.9.16

# Use baseimage-docker's init system.
CMD ["/sbin/my_init"]

# Tell debconf to run in non-interactive mode
ENV DEBIAN_FRONTEND noninteractive


# Update the source list for appropriate repository, trusty 14.04 LTS, in this case.
# Generated from:
# https://wiki.ubuntu.com/DevelopmentCodeNames
# http://repogen.simplylinux.ch/

RUN echo "deb http://fr.archive.ubuntu.com/ubuntu/ trusty main" >> /etc/apt/sources.list
RUN echo "deb-src http://fr.archive.ubuntu.com/ubuntu/ trusty main universe" >> /etc/apt/sources.list
RUN echo "deb http://fr.archive.ubuntu.com/ubuntu/ trusty-security main" >> /etc/apt/sources.list
RUN echo "deb http://fr.archive.ubuntu.com/ubuntu/ trusty-updates main" >> /etc/apt/sources.list
RUN echo "deb-src http://fr.archive.ubuntu.com/ubuntu/ trusty-security main universe" >> /etc/apt/sources.list
RUN echo "deb-src http://fr.archive.ubuntu.com/ubuntu/ trusty-updates main universe" >> /etc/apt/sources.list
RUN apt-get update && apt-get install -y wget git

# Enable SSH loging provided by Baseimage docker and regenerate keys
RUN rm -f /etc/service/sshd/down
RUN /etc/my_init.d/00_regen_ssh_host_keys.sh
RUN mkdir -p /root/.ssh
ADD id_rsa.pub /tmp/id_rsa.pub
RUN cat /tmp/id_rsa.pub >> /root/.ssh/authorized_keys && rm -f /tmp/id_rsa.pub

#make quagga service dir
RUN mkdir /etc/service/quagga

# Install Quagga
RUN sudo apt-get install -y quagga telnet

# Expose ports that quagga, BGP use (179 is bgp, rest are quagga mngmt)
EXPOSE 179 2601 2602 2603 2604 2605

# enable daemons
RUN sed -i 's/bgpd=no/bgpd=yes/g' /etc/quagga/daemons
RUN sed -i 's/zebra=no/zebra=yes/g' /etc/quagga/daemons

# copy the default configs for the routing daemons
ADD conf/bgpd.conf /etc/quagga/bgpd.conf
ADD conf/babeld.conf /etc/quagga/babeld.conf
ADD conf/zebra.conf /etc/quagga/zebra.conf
ADD conf/vtysh.conf /etc/quagga/vtysh.conf

#RUN echo VTYSH_PAGER=more >> /etc/environment
#RUN echo export VTYSH_PAGER=more >> /etc/bash.bashrc

ADD quagga.sh /etc/service/quagga/run
CMD ["/etc/init.d/quagga","start"]
#entrypoint ["/etc/init.d/quagga"]

# Map a container directory to Docker host directory (not in the other direction)
VOLUME /etc/quagga/

# Install supervisord
#RUN sudo apt-get install -y  supervisor
#RUN mkdir -p /var/log/supervisor

# Miscellaneous tools
#RUN sudo apt-get install -y iperf inetutils-traceroute iputils-tracepath \
#mtr dnsutils sip-tester build-essential sip-tester tcpdump packeth libasound2-dev libpcap-dev libssl-dev
#RUN sudo apt-get install -y libnetfilter-queue-dev

# Install IPv6-THC tool
#RUN git clone https://github.com/vanhauser-thc/thc-ipv6
#WORKDIR thc-ipv6/
#RUN make && make install
