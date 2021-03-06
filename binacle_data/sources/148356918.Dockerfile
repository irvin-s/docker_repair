FROM base/archlinux

RUN pacman -Sy

# toolchain
RUN pacman -S --noconfirm base-devel cmake extra-cmake-modules python
# kf5 and qt5 libraries
RUN pacman -S --noconfirm plasma-framework

# required by tests
RUN pacman -S --noconfirm xorg-server-xvfb
