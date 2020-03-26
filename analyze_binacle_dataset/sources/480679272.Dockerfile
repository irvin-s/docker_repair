FROM debian:8
MAINTAINER Duzy Chan <code@duzy.info>

RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y \
  git \
  libgl1-mesa-dri \
  net-tools \
  menu \
  sudo \
  weston

RUN useradd -m -s /bin/bash user

USER root
RUN echo "user ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/user

ENV DISPLAY :0
ENV XDG_RUNTIME_DIR /var/lib/wayland
RUN mkdir -p /var/lib/wayland && \
    chmod 0700 /var/lib/wayland

# The default VNC port is 5900
EXPOSE 5900

WORKDIR /root
CMD weston
