FROM rafaelsoares/archlinux:latest
MAINTAINER Rafael Soares

# Install base-devel
RUN pacman -S --needed --noprogressbar --noconfirm base-devel git; pacman -Scc --noprogressbar --noconfirm
