FROM ubuntu:15.04

MAINTAINER Tim Petter <tim@timpetter.de>

RUN apt-get update --assume-yes --quiet
RUN apt-get install --assume-yes --quiet --force-yes wget yasm autoconf automake build-essential libass-dev \
    libfreetype6-dev libgpac-dev libsdl1.2-dev libtheora-dev libtool libva-dev libvdpau-dev libvorbis-dev \
    libxcb1-dev libxcb-shm0-dev libxcb-xfixes0-dev pkg-config texi2html zlib1g-dev libx264-dev libmp3lame-dev

RUN mkdir -p /build /ffmpeg_sources /ffmpeg_build

ADD . /

RUN chmod +x /build-ffmpeg.sh

VOLUME ["/build"]
WORKDIR /build

CMD ["/build-ffmpeg.sh"]
