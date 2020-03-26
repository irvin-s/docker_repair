FROM dockercask/base-xorg
MAINTAINER Zachary Huff <zach.huff.386@gmail.com>

RUN pacman -Sdd --noconfirm chromium ffmpeg gst-plugins-good

ADD init.sh .
CMD ["sh", "init.sh"]
