FROM debian:jessie
RUN useradd -u 1000 -ms /bin/bash gamer
RUN echo "deb http://httpredir.debian.org/debian jessie non-free" >> /etc/apt/sources.list
RUN apt-get update -y
RUN apt-get install -y mesa-utils xserver-xorg-video-all mame alsa-base alsa-utils -y
RUN apt-get install libasound2 -y
COPY asound.conf /etc/asound.conf
COPY default.conf /etc/modprobe.d/default.conf
USER gamer
RUN mkdir -p /home/gamer/mame/roms
COPY roms/ /home/gamer/mame/roms/
RUN ln -s /home/gamer/mame /home/gamer/.mame
