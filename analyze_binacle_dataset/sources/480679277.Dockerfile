#FROM ubuntu:yakkety
FROM ubuntu
MAINTAINER Duzy Chan <code@duzy.info>

# RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y \
#   libgl1-mesa-dri \
#   net-tools \
#   sudo \
#   weston
#   
################################################################################
# The following additional packages will be installed:
#    dbus fontconfig fontconfig-config fonts-dejavu-core libapparmor1 libbsd0
#   libcairo2 libcolord2 libdatrie1 libdbus-1-3 libdrm-amdgpu1 libdrm-intel1
#   libdrm-nouveau2 libdrm-radeon1 libdrm2 libedit2 libegl1-mesa libelf1
#   libevdev2 libexpat1 libffi6 libfontconfig1 libfreetype6 libgbm1
#   libglapi-mesa libgles2-mesa libglib2.0-0 libglib2.0-data libgraphite2-3
#   libgudev-1.0-0 libharfbuzz0b libicu57 libinput-bin libinput10 libjpeg-turbo8
#   libjpeg8 liblcms2-2 libllvm3.8 libmtdev1 libpango-1.0-0 libpangocairo-1.0-0
#   libpangoft2-1.0-0 libpciaccess0 libpixman-1-0 libpng16-16 libthai-data
#   libthai0 libtxc-dxtn-s2tc0 libwacom-bin libwacom-common libwacom2
#   libwayland-client0 libwayland-cursor0 libwayland-egl1-mesa
#   libwayland-server0 libx11-6 libx11-data libx11-xcb1 libxau6
#   libxcb-composite0 libxcb-dri2-0 libxcb-dri3-0 libxcb-present0 libxcb-render0
#   libxcb-shm0 libxcb-sync1 libxcb-xfixes0 libxcb-xkb1 libxcb1 libxcursor1
#   libxdmcp6 libxext6 libxfixes3 libxkbcommon0 libxml2 libxrender1
#   libxshmfence1 sgml-base shared-mime-info ucf xdg-user-dirs xkb-data xml-core
# Suggested packages:
#   default-dbus-session-bus | dbus-session-bus colord liblcms2-utils pciutils
#   sgml-base-doc debhelper
# The following NEW packages will be installed:
#   dbus fontconfig fontconfig-config fonts-dejavu-core libapparmor1 libbsd0
#   libcairo2 libcolord2 libdatrie1 libdbus-1-3 libdrm-amdgpu1 libdrm-intel1
#   libdrm-nouveau2 libdrm-radeon1 libdrm2 libedit2 libegl1-mesa libelf1
#   libevdev2 libexpat1 libffi6 libfontconfig1 libfreetype6 libgbm1
#   libgl1-mesa-dri libglapi-mesa libgles2-mesa libglib2.0-0 libglib2.0-data
#   libgraphite2-3 libgudev-1.0-0 libharfbuzz0b libicu57 libinput-bin libinput10
#   libjpeg-turbo8 libjpeg8 liblcms2-2 libllvm3.8 libmtdev1 libpango-1.0-0
#   libpangocairo-1.0-0 libpangoft2-1.0-0 libpciaccess0 libpixman-1-0
#   libpng16-16 libthai-data libthai0 libtxc-dxtn-s2tc0 libwacom-bin
#   libwacom-common libwacom2 libwayland-client0 libwayland-cursor0
#   libwayland-egl1-mesa libwayland-server0 libx11-6 libx11-data libx11-xcb1
#   libxau6 libxcb-composite0 libxcb-dri2-0 libxcb-dri3-0 libxcb-present0
#   libxcb-render0 libxcb-shm0 libxcb-sync1 libxcb-xfixes0 libxcb-xkb1 libxcb1
#   libxcursor1 libxdmcp6 libxext6 libxfixes3 libxkbcommon0 libxml2 libxrender1
#   libxshmfence1 net-tools sgml-base shared-mime-info sudo ucf weston
#   xdg-user-dirs xkb-data xml-core

RUN cp /etc/apt/sources.list /etc/apt/sources.list.backup
COPY sources.list /etc/apt/sources.list

## net-tools for ping
RUN apt-get update && apt-cache show \
    libgl1-mesa-dri \
    net-tools \
    sudo \
    weston

## Install `sudo'
RUN apt-get install --fix-missing -y libaudit1
RUN apt-get install --fix-missing -y libc6
RUN apt-get install --fix-missing -y libpam0g
RUN apt-get install --fix-missing -y libselinux1
RUN apt-get install --fix-missing -y libpam-modules
RUN apt-get install --fix-missing -y sudo

## Install `net-tools' (Depends: libc6 (>= 2.14), libselinux1 (>= 1.32))
RUN apt-get install --fix-missing -y net-tools

## Install `libgl1-mesa-dri'
RUN apt-get install --fix-missing -y libdrm-amdgpu1
RUN apt-get install --fix-missing -y libdrm-intel1
RUN apt-get install --fix-missing -y libdrm-nouveau2
#RUN apt-get install --fix-missing -y libdrm-radeon1
RUN apt-get install --fix-missing -y libdrm2
RUN apt-get install --fix-missing -y libelf1
RUN apt-get install --fix-missing -y libexpat1
RUN apt-get install --fix-missing -y libgcc1
RUN apt-get install --fix-missing -y libgcrypt20
RUN apt-get install --fix-missing -y libllvm3.8
RUN apt-get install --fix-missing -y libstdc++6
RUN apt-get install --fix-missing -y libgl1-mesa-dri

## Install `weston'
RUN apt-get install --fix-missing -y adduser
RUN apt-get install --fix-missing -y libegl1-mesa
RUN apt-get install --fix-missing -y libwayland-egl1-mesa
RUN apt-get install --fix-missing -y libgles2-mesa
RUN apt-get install --fix-missing -y libc6
RUN apt-get install --fix-missing -y libcairo2
RUN apt-get install --fix-missing -y libcolord2
RUN apt-get install --fix-missing -y libdbus-1-3
RUN apt-get install --fix-missing -y libdrm2
RUN apt-get install --fix-missing -y libgbm1
RUN apt-get install --fix-missing -y libglib2.0-0
RUN apt-get install --fix-missing -y libinput10
RUN apt-get install --fix-missing -y libjpeg8
RUN apt-get install --fix-missing -y liblcms2-2
RUN apt-get install --fix-missing -y libpam0g
RUN apt-get install --fix-missing -y libpango-1.0-0
RUN apt-get install --fix-missing -y libpangocairo-1.0-0
RUN apt-get install --fix-missing -y libpixman-1-0
RUN apt-get install --fix-missing -y libpng16-16
RUN apt-get install --fix-missing -y libsystemd0
RUN apt-get install --fix-missing -y libudev1
RUN apt-get install --fix-missing -y libwayland-client0
RUN apt-get install --fix-missing -y libwayland-cursor0
RUN apt-get install --fix-missing -y libwayland-server0
RUN apt-get install --fix-missing -y libxcb-composite0
RUN apt-get install --fix-missing -y libxcb-render0
RUN apt-get install --fix-missing -y libxcb-shm0
RUN apt-get install --fix-missing -y libxcb-xfixes0
RUN apt-get install --fix-missing -y libxcb-xkb1
RUN apt-get install --fix-missing -y libxcb1
RUN apt-get install --fix-missing -y libxcursor1
RUN apt-get install --fix-missing -y libxkbcommon0
RUN apt-get install --fix-missing -y weston

RUN useradd -m -s /bin/bash user
RUN echo "user ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/user

ENV DISPLAY :0
ENV XDG_RUNTIME_DIR /var/lib/wayland
RUN mkdir -p /var/lib/wayland && chmod 0700 /var/lib/wayland

USER root
WORKDIR /root
CMD weston-launch
