FROM ubuntu:16.04

RUN dpkg --add-architecture i386
RUN apt-get update
RUN apt-get install -y tofrodos
RUN apt-get install -y iproute2
RUN apt-get install -y gawk
RUN apt-get install -y xvfb
RUN apt-get install -y gcc-4.8
RUN apt-get install -y git
RUN apt-get install -y make
RUN apt-get install -y net-tools
RUN apt-get install -y libncurses5-dev
RUN apt-get install -y tftpd
RUN apt-get install -y tftp-hpa
RUN apt-get install -y zlib1g-dev:i386
RUN apt-get install -y libssl-dev
RUN apt-get install -y flex
RUN apt-get install -y bison
RUN apt-get install -y libselinux1
RUN apt-get install -y gnupg
RUN apt-get install -y wget
RUN apt-get install -y diffstat
RUN apt-get install -y chrpath
RUN apt-get install -y socat
RUN apt-get install -y xterm
RUN apt-get install -y autoconf
RUN apt-get install -y libtool
RUN apt-get install -y tar
RUN apt-get install -y unzip
RUN apt-get install -y texinfo
RUN apt-get install -y zlib1g-dev
RUN apt-get install -y gcc-multilib
RUN apt-get install -y build-essential
RUN apt-get install -y libsdl1.2-dev
RUN apt-get install -y libglib2.0-dev
RUN apt-get install -y screen
RUN apt-get install -y expect
RUN apt-get install -y locales
RUN apt-get install -y cpio
RUN apt-get install -y sudo

RUN echo "%sudo ALL=(ALL:ALL) ALL" >> /etc/sudoers
RUN echo "%sudo ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

# Set locale
RUN locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8  
ENV LANGUAGE en_US:en  
ENV LC_ALL en_US.UTF-8 

RUN apt-get install -y software-properties-common
RUN echo "\r" | add-apt-repository ppa:deadsnakes/ppa
RUN apt-get update && apt-get install -y python3.4

RUN useradd petalinux
RUN chmod +w /opt
RUN chown -R petalinux:petalinux /opt
RUN mkdir -p /home/petalinux/workspace
RUN chown -R petalinux:petalinux /home/petalinux
WORKDIR /opt
USER petalinux
ARG host_ip=192.168.1.101
ENV host_ip ${host_ip}
RUN wget -q ${host_ip}:8000/resources/petalinux-v2017.1-final-installer.run
RUN chmod a+x petalinux-v2017.1-final-installer.run
RUN wget -q ${host_ip}:8000/resources/Xilinx_SDK_2017.1_0415_1_Lin64.bin
RUN chmod a+x Xilinx_SDK_2017.1_0415_1_Lin64.bin

ENV DEBIAN_FRONTEND noninteractive

USER root

RUN apt-get update
RUN apt-get install -y gnome-terminal
RUN apt-get install -y tightvncserver

RUN mkdir -p /root/.vnc

ADD xstartup /root/.vnc/xstartup
ADD passwd /root/.vnc/passwd

RUN sudo chmod 600 /root/.vnc/passwd

RUN sudo rm /tmp/.X1-lock || :
RUN sudo rm /bin/sh && ln -s /bin/bash /bin/sh
CMD sudo /usr/bin/vncserver :1 -geometry 1280x800 -depth 24 && sudo tail -f /root/.vnc/*:1.log


EXPOSE 5901
