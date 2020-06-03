FROM dockercask/base-xorg
MAINTAINER Zachary Huff <zach.huff.386@gmail.com>

RUN aurget studio-3t
RUN pacman -U --noconfirm /aur/studio-3t*.pkg.tar
RUN rm -rf /aur

ADD init.sh .
CMD ["sh", "init.sh"]
