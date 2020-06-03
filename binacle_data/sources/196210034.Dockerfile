FROM dockercask/base
MAINTAINER Zachary Huff <zach.huff.386@gmail.com>

RUN pacman -S --noconfirm nvidia nvidia-libgl opencl-nvidia lib32-nvidia-libgl

RUN pacman -S --noconfirm xorg-xauth xfce4 xfce4-notifyd lxappearance numix-gtk-theme gtk-engines gtk-engine-aurora gtk-engine-murrine human-icon-theme xcursor-vanilla-dmz
