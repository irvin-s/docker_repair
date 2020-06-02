FROM dockercask/base
MAINTAINER Zachary Huff <zach.huff.386@gmail.com>

RUN pacman -S --noconfirm xf86-video-intel mesa-libgl opencl-mesa lib32-mesa-libgl

RUN pacman -S --noconfirm xorg-xauth xfce4 xfce4-notifyd lxappearance numix-gtk-theme gtk-engines gtk-engine-aurora gtk-engine-murrine human-icon-theme xcursor-vanilla-dmz
