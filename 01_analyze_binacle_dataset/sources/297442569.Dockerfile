############################################################
# Dockerfile to create stable build environment for electronpass-desktop repo
# Based on Ubuntu
############################################################

# Set the base image to Ubuntu
FROM ubuntu:17.10

MAINTAINER Ziga Patacko Koderman

RUN apt-get update

################## BEGIN INSTALLATION ######################

# Update the repository sources list once more
RUN apt-get update

# Install MongoDB package (.deb)
RUN apt-get install -y build-essential cmake curl fuse python3 git wget libgl1-mesa-dev desktop-file-utils qt5-default qtbase5-dev qtquickcontrols2-5-dev libqt5svg5 qtdeclarative5-dev qml-module-qtgraphicaleffects qml-module-qtquick-controls2 qml-module-qtquick-layouts qml-module-qt-labs-settings qml-module-qtquick-dialogs

##################### INSTALLATION END #####################

# download travis build script
RUN mkdir -p /root/build
RUN cd /root/build && wget https://raw.githubusercontent.com/electronpass/electronpass-desktop/develop/.builder/docker_build.sh && chmod +x docker_build.sh
# Set default container command
ENTRYPOINT /root/build/docker_build.sh
