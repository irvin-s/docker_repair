FROM ubuntu:18.04
MAINTAINER Omer Zak "w1@zak.co.il"

# Before installing packages which might need kvmgid and video groups.
ADD .docker.uids_gids /tmp
RUN . /tmp/.docker.uids_gids && addgroup --gid ${kvmgid} kvm && \
   ( test "x`egrep ^video /etc/group|cut -d':' -f3`" = "x${videogid}" ; RC=$? ; \
   if [ $RC -ne 0 ] ; then echo "Incompatible video gid, you will not be able to run emulator" ; exit 1 ; fi)
# We use also group libvirt but its gid need not be the same as on the host system.

RUN apt-get update && \
# Source: https://stackoverflow.com/questions/44331836/apt-get-install-tzdata-noninteractive
    export DEBIAN_FRONTEND=noninteractive && \
    apt-get install -y tzdata && \
    ln -fs /usr/share/zoneinfo/Greenwich /etc/localtime && \
    dpkg-reconfigure --frontend noninteractive tzdata && \
    apt-get install -y --no-install-recommends \
      ubuntu-desktop sudo

#RUN apt-get install -y --no-install-recommends \
#   qemu-kvm \
#   libgl1-mesa-dri libgl1-mesa-dev \
#   libdrm-intel1 libdrm-nouveau2 libdrm-radeon1 \
#   libelf1 libllvm3.4 libpciaccess0 libtxc-dxtn-s2tc0 && \
#    dpkg --add-architecture i386 && apt-get update && \
#    apt-get install -y --no-install-recommends libc6:i386 libncurses5:i386 libstdc++6:i386 && \
#    echo do not do "rm -rf /var/lib/apt/lists/*" because we want to update once in a while

RUN . /tmp/.docker.uids_gids && \
    echo "developer:x:${uid}:${gid}:Developer,,,:/AndroidStudio/home:/bin/bash" >> /etc/passwd && \
    echo "developer:x:${gid}:" >> /etc/group && \
    adduser developer kvm && \
    adduser developer video && \
    chmod 0660 /etc/sudoers && \
    echo "developer ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers && \
    chmod 0440 /etc/sudoers

RUN sudo apt-get install -y --no-install-recommends \
      git curl && \
    sudo curl -sL https://deb.nodesource.com/setup_10.x | sudo -E bash - && \
    sudo apt-get update && \
    sudo apt-get install -y --no-install-recommends \
      build-essential \
      nodejs && \
    sudo npm install -g uglify-js

RUN sudo apt-get install -y --no-install-recommends \
      firefox vim       \
      bridge-utils      \
      cpu-checker       \
      libvirt-bin libvirt-clients libvirt-daemon-system \
      qemu qemu-kvm     \
      ubuntu-vm-builder \
      virt-manager virtinst && \
    adduser developer libvirt

ADD 51-android.rules /etc/udev/rules.d
RUN chmod a+r /etc/udev/rules.d/51-android.rules
ADD run_studio.sh /home/run_studio.sh
RUN chmod +x /home/run_studio.sh

USER developer
ENV HOME=/AndroidStudio/home DISPLAY=:0 SHELL=/bin/bash
ENV ANDROID_HOME=$HOME/Android/Sdk
ENV PATH=$PATH:$ANDROID_HOME/tools:$ANDROID_HOME/platform-tools

ENTRYPOINT /home/run_studio.sh