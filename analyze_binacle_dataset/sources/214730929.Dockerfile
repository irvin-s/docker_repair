FROM ubuntu:14.04
MAINTAINER Chester Kuo <chester.kuo@gmail.com>

RUN apt-get update && apt-get -y install curl
RUN apt-get -y install gcc g++ gdb
RUN apt-get -y --no-install-recommends install cmake mercurial git make subversion
RUN apt-get -y install python python-dev python-pip vim
RUN apt-get -y install debhelper execstack dh-modaliases 
RUN apt-get -y install libxrandr2 libice6 libsm6 libfontconfig1 libxi6 libxcursor1 libgl1-mesa-glx libxinerama1 libqtgui4 xserver-xorg-dev
RUN apt-get -y install libxrender-dev libxext6 libx11-dev libxau6 libxdmcp6
RUN apt-get -y install xserver-xorg-core
RUN apt-get -y install libc6-i386 lib32gcc1 dkms

RUN mkdir -p /tmp
COPY amd-driver-installer-14.41-x86.x86_64.run /tmp/

RUN /tmp/amd-driver-installer-14.41-x86.x86_64.run --buildpkg Ubuntu/trusty
RUN dpkg -i /fglrx_14.410-0ubuntu1_amd64.deb 
RUN dpkg -i /fglrx-dev_14.410-0ubuntu1_amd64.deb
RUN dpkg -i /fglrx-amdcccle_14.410-0ubuntu1_amd64.deb

RUN rm /fglrx_14.410-0ubuntu1_amd64.deb
RUN rm /fglrx-dev_14.410-0ubuntu1_amd64.deb
RUN rm /fglrx-amdcccle_14.410-0ubuntu1_amd64.deb 
RUN rm /fglrx-installer_14.410-0ubuntu1_amd64.changes

RUN /usr/lib/fglrx/bin/clinfo

