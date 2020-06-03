FROM docker.io/ubuntu:16.04
LABEL name=netease-cloud-music-docker-version
MAINTAINER qzwlecr<qzwlecr@gmail.com>

ARG NETEASE_URL=http://s1.music.126.net/download/pc/netease-cloud-music_1.0.0-2_amd64_ubuntu16.04.deb

RUN \
    apt-get update && \
    apt-get install -y --no-install-recommends ca-certificates wget dbus-x11 libcanberra-gtk-module fonts-wqy-microhei packagekit-gtk3-module&& \
    wget -O /tmp/netease.deb "$NETEASE_URL" && \
    apt-get install -y --no-install-recommends /tmp/netease.deb && \
    rm /tmp/netease.deb && \
    apt-get remove -y wget 

CMD ["/usr/bin/netease-cloud-music","--no-sandbox"]
ENV LANG=zh_CN.UTF-8
