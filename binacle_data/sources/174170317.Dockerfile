# Name: webrtcDocker
# Description: installs webrtc in ubuntu trusty 14.04 environment
#
# VERSION       1.0
#

# Use the ubuntu base image
FROM ubuntu:trusty

MAINTAINER Oleg Blinnikov, osblinnikov@gmail.com

# make sure the package repository is up to date
RUN apt-get update
RUN apt-get -y upgrade

# Adding vnc server
# no Upstart or DBus
# https://github.com/dotcloud/docker/issues/1724#issuecomment-26294856
RUN apt-mark hold initscripts udev plymouth mountall
RUN dpkg-divert --local --rename --add /sbin/initctl && ln -sf /bin/true /sbin/initctl

RUN apt-get install -y --force-yes --no-install-recommends supervisor \
        openssh-server pwgen sudo vim-tiny \
        net-tools \
        lxde x11vnc xvfb \
        gtk2-engines-murrine ttf-ubuntu-font-family \
        nodejs wget curl

RUN apt-get install -y git git-svn subversion
RUN apt-get install -y openjdk-7-jdk

# Now create the webrtc user itself
RUN adduser --gecos "webRTC User" --disabled-password webrtc
RUN usermod -a -G dialout webrtc
ADD 99_aptget /etc/sudoers.d/99_aptget
RUN chmod 0440 /etc/sudoers.d/99_aptget && chown root:root /etc/sudoers.d/99_aptget
RUN echo "    ForwardX11Trusted yes\n" >> /etc/ssh/ssh_config

RUN mkdir -p /home/webrtc && chown webrtc:webrtc /home/webrtc

# And, as that user...
USER webrtc

# clone depot tools from chromium project
RUN cd /home/webrtc && git clone https://chromium.googlesource.com/chromium/tools/depot_tools.git

RUN mkdir -p /home/webrtc/webrtc.googlecode.com
RUN cd /home/webrtc/webrtc.googlecode.com && \
    wget https://src.chromium.org/svn/trunk/src/build/install-build-deps.sh && \
    wget https://src.chromium.org/svn/trunk/src/build/install-build-deps-android.sh && \
    chmod 755 install-build-deps.sh && \
    chmod 755 install-build-deps-android.sh

RUN mkdir -p /home/webrtc/webrtc.googlecode.com/linux && \
    cd /home/webrtc/webrtc.googlecode.com/linux && \
    wget https://src.chromium.org/svn/trunk/src/build/linux/install-chromeos-fonts.py && \
    chmod u+rx install-chromeos-fonts.py

# as root...
USER root

RUN dpkg --add-architecture i386 && \
    echo    "deb http://us.archive.ubuntu.com/ubuntu/ trusty multiverse\n \
            deb-src http://us.archive.ubuntu.com/ubuntu/ trusty multiverse\n \
            deb http://us.archive.ubuntu.com/ubuntu/ trusty-updates multiverse\n \
            deb-src http://us.archive.ubuntu.com/ubuntu/ trusty-updates multiverse\n \
            deb http://archive.canonical.com/ trusty partner" >> /etc/apt/sources.list && \
    apt-get update && \ 
    apt-get install -y lsb-release file gcc-multilib

RUN /home/webrtc/webrtc.googlecode.com/install-build-deps.sh --no-prompt --syms && \
    /home/webrtc/webrtc.googlecode.com/install-build-deps-android.sh --no-prompt --syms

USER webrtc

RUN cd /home/webrtc/webrtc.googlecode.com && \
    JAVA_HOME=/usr/lib/jvm/java-7-openjdk-amd64 \
    PATH=$PATH:/home/webrtc/depot_tools \
    GYP_DEFINES="enable_tracing=1 build_with_libjingle=1 build_with_chromium=0 libjingle_java=1 OS=android" \
    GYP_GENERATOR_FLAGS="output_dir=out_android" \
    fetch webrtc_android

# RUN cd /home/webrtc/webrtc.googlecode.com && \
#     PATH=$PATH:/home/webrtc/depot_tools gclient config http://webrtc.googlecode.com/svn/trunk && \
#     echo "target_os = ['android', 'unix']" >> .gclient && \
#     JAVA_HOME=/usr/lib/jvm/java-7-openjdk-amd64/ PATH=$PATH:/home/webrtc/depot_tools gclient sync --force --jobs 100 && \
#RUN cd /home/webrtc/webrtc.googlecode.com && chown -R webrtc:webrtc *

RUN cd /home/webrtc/webrtc.googlecode.com/src && \
    GYP_DEFINES="enable_tracing=1 build_with_libjingle=1 build_with_chromium=0 libjingle_java=1 OS=android" \
    GYP_GENERATOR_FLAGS="output_dir=out_android" \
    JAVA_HOME=/usr/lib/jvm/java-7-openjdk-amd64/ PATH=$PATH:/home/webrtc/depot_tools gclient runhooks && \
    JAVA_HOME=/usr/lib/jvm/java-7-openjdk-amd64/ PATH=$PATH:/home/webrtc/depot_tools ninja -C out_android/Debug AppRTCDemo && \
    JAVA_HOME=/usr/lib/jvm/java-7-openjdk-amd64/ PATH=$PATH:/home/webrtc/depot_tools ninja -C out_android/Release AppRTCDemo

RUN cd /home/webrtc/webrtc.googlecode.com/src && \
    GYP_DEFINES="enable_tracing=1 build_with_libjingle=1 build_with_chromium=0 libjingle_java=1" \
    GYP_GENERATOR_FLAGS="output_dir=out" \
    JAVA_HOME=/usr/lib/jvm/java-7-openjdk-amd64/ PATH=$PATH:/home/webrtc/depot_tools gclient runhooks && \
    JAVA_HOME=/usr/lib/jvm/java-7-openjdk-amd64/ PATH=$PATH:/home/webrtc/depot_tools ninja -C out/Debug && \
    JAVA_HOME=/usr/lib/jvm/java-7-openjdk-amd64/ PATH=$PATH:/home/webrtc/depot_tools ninja -C out/Release


USER root
# Launch bash when launching the container
ADD startcontainer /usr/local/bin/startcontainer
RUN chmod 755 /usr/local/bin/startcontainer

# as a user...
USER webrtc

# ADD build.bash /home/webrtc/webrtc.googlecode.com/src/build.bash
# RUN sudo chmod 755 /home/webrtc/webrtc.googlecode.com/src/build.bash
# RUN /home/webrtc/webrtc.googlecode.com/src/build.bash

ADD noVNC /noVNC/
ADD supervisord.conf /

ADD bashrc /.bashrc
ADD bashrc /home/webrtc/.bashrc

RUN mkdir -p /home/webrtc/Desktop
ADD xterm /home/webrtc/Desktop/

CMD ["/bin/bash"]
ENTRYPOINT ["/usr/local/bin/startcontainer"]



