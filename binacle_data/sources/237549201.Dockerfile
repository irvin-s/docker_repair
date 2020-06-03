FROM ubuntu:16.04

MAINTAINER Team 900

# docker run -it --privileged --net=host -v /tmp/.X11-unix:/tmp/.X11-unix -e DISPLAY=$DISPLAY ubuntu:16.04 /bin/bash

RUN apt update && \
    DEBIAN_FRONTEND=noninteractive apt upgrade -y && \
    echo "resolvconf resolvconf/linkify-resolvconf boolean false" | debconf-set-selections && \
    echo "debconf shared/accepted-oracle-license-v1-1 select true" | debconf-set-selections && \
    DEBIAN_FRONTEND=noninteractive apt install -y ubuntu-minimal ubuntu-standard software-properties-common && \
    DEBIAN_FRONTEND=noninteractive apt purge -y plymouth plymouth-theme-ubuntu-text libdrm2 libdrm-common libplymouth4 && \
    DEBIAN_FRONTEND=noninteractive apt-add-repository -y ppa:wpilib/toolchain && \
    DEBIAN_FRONTEND=noninteractive apt-add-repository -y ppa:wpilib/toolchain-beta && \
    DEBIAN_FRONTEND=noninteractive apt-add-repository -y ppa:webupd8team/java && \
    apt update && \
    DEBIAN_FRONTEND=noninteractive apt install -y git libc6-i386 curl jstest-gtk gradle oracle-java8-installer frc-toolchain meshlab cmake libprotobuf-dev libprotoc-dev protobuf-compiler ninja-build sip-dev python-empy libtinyxml2-dev libeigen3-dev libpython2.7-dev libswt-gtk-3-jni libswt-gtk-3-java && \
    DEBIAN_FRONTEND=noninteractive apt clean && \
    useradd -ms /bin/bash -G sudo -p ubuntu ubuntu

# useradd -p option to set the password does not appear to work. May have to
# set the password manually as root.

USER ubuntu

RUN cd && \
    wget http://www.ctr-electronics.com/downloads/lib/CTRE_Phoenix_FRCLibs_NON-WINDOWS_v5.7.1.0.zip && \
    mkdir ctre && \
    cd ctre && \
    unzip ../CTRE_Phoenix_FRCLibs_NON-WINDOWS_v5.7.1.0.zip && \
    mkdir -p ~/wpilib/user && \
    cp -r cpp ~/wpilib/user && \
    cd .. && \
    rm -rf ctre CTRE_Phoenix_FRCLibs_NON-WINDOWS_v5.7.1.0.zip && \
    cd && \
    wget https://www.kauailabs.com/public_files/navx-mxp/navx-mxp-libs.zip && \
    mkdir navx && \
    cd navx && \
    unzip ../navx-mxp-libs.zip && \
    rsync -a roborio/cpp/ ~/wpilib/user/cpp/ && \
    cd .. && \
    rm -rf navx navx-mxp-libs.zip




#    mkdir -p ~/Downloads && \
#    cd ~/Downloads && \
#    wget http://mirror.csclub.uwaterloo.ca/eclipse/oomph/epp/neon/R/eclipse-inst-linux64.tar.gz && \
#    tar zxvf eclipse-inst-linux64.tar.gz && \
#    cd eclipse-installer && \
#    ./eclipse-inst

