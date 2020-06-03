# Copyright ClusterHQ Inc.  See LICENSE file for details.

FROM ubuntu:14.04
MAINTAINER Madhuri Yechuri <madhuri.yechuri@clusterhq.com>

# Note: apt-get install requires the `-1` (epoch) suffix.
ENV FLOCKER_VERSION 1.8.0-1

RUN sudo apt-get update
RUN sudo apt-get -y install apt-transport-https software-properties-common
RUN sudo add-apt-repository -y ppa:james-page/docker
RUN sudo add-apt-repository -y "deb https://clusterhq-archive.s3.amazonaws.com/ubuntu/$(lsb_release --release --short)/\$(ARCH) /"

RUN sudo apt-get update && sudo apt-get -y --force-yes install \
      clusterhq-python-flocker=${FLOCKER_VERSION} \
      clusterhq-flocker-node=${FLOCKER_VERSION}

RUN sudo apt-get -y --force-yes install \
      git \
      build-essential \
      libncurses5-dev \
      libslang2-dev \
      gettext \
      zlib1g-dev \
      libselinux1-dev \
      debhelper \
      lsb-release \
      pkg-config \
      po-debconf \
      autoconf \
      automake \
      autopoint \
      libtool

RUN sudo git clone git://git.kernel.org/pub/scm/utils/util-linux/util-linux.git util-linux
RUN sudo bash -c "cd util-linux; \
                  ./autogen.sh; \
                  ./configure --without-python --disable-all-programs --enable-nsenter; \
                  make"
RUN sudo cp /util-linux/nsenter /bin

ADD wrap_command.sh /tmp/wrap_command.sh

RUN bash /tmp/wrap_command.sh /bin mount 4755
RUN bash /tmp/wrap_command.sh /bin umount 4755
RUN bash /tmp/wrap_command.sh /bin lsblk 755
RUN bash /tmp/wrap_command.sh /sbin losetup 755
RUN bash /tmp/wrap_command.sh /sbin mkfs 755
RUN bash /tmp/wrap_command.sh /sbin blkid 755

# A patched version of flocker-ca which allows the Node UUID to be supplied as
# an environment variable.
# XXX: Implement this in Flocker (FLOC-190)
ADD flocker-ca /opt/flocker/bin/flocker-ca
RUN chmod a+x /opt/flocker/bin/flocker-ca
