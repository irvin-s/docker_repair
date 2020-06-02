FROM dockercask/base-xorg
MAINTAINER Zachary Huff <zach.huff.386@gmail.com>

RUN pacman -Sdd --noconfirm ffmpeg gst-plugins-good

RUN aurget google-chrome
RUN pacman -U --noconfirm /aur/google-chrome*.pkg.tar
RUN rm -rf /aur

ADD init.sh .
CMD ["sh", "init.sh"]
