FROM dockercask/base-xorg
MAINTAINER Zachary Huff <zach.huff.386@gmail.com>

RUN aurget libcurl-compat
RUN pacman -U --noconfirm /aur/libcurl-compat*.pkg.tar

RUN aurget spotify
RUN pacman -U --noconfirm /aur/spotify*.pkg.tar

RUN rm -rf /aur

ADD init.sh .
CMD ["sh", "init.sh"]
