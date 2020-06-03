FROM dockercask/base
MAINTAINER Zachary Huff <zach.huff.386@gmail.com>

RUN add-apt-repository --yes ppa:graphics-drivers/ppa
RUN apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get install --assume-yes nvidia-370 nvidia-settings nvidia-libopencl1-370 nvidia-opencl-icd-370

RUN DEBIAN_FRONTEND=noninteractive apt-get install --assume-yes libcairo2 libfreetype6 fontconfig
RUN DEBIAN_FRONTEND=noninteractive apt-get install --assume-yes light-themes human-icon-theme gnome-human-icon-theme

RUN DEBIAN_FRONTEND=noninteractive apt-get install --assume-yes xauth xfce4 xfce4-notifyd lxappearance gtk2-engines gtk2-engines-aurora gtk2-engines-murrine gtk3-engines-xfce xcursor-themes dmz-cursor-theme

RUN add-apt-repository --yes ppa:numix/ppa
RUN apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get install --assume-yes numix-gtk-theme
