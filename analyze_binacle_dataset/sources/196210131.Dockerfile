FROM dockercask/base-xorg
MAINTAINER Zachary Huff <zach.huff.386@gmail.com>

RUN apt-get install --assume-yes ffmpeg libgstreamer-plugins-good1.0-0

RUN add-apt-repository --yes ppa:ubuntu-mozilla-daily/firefox-aurora
RUN apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get install --assume-yes firefox

RUN apt-get install --assume-yes flashplugin-installer

ADD init.sh .
CMD ["sh", "init.sh"]
