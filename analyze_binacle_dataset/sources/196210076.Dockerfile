FROM dockercask/base-xorg
MAINTAINER Zachary Huff <zach.huff.386@gmail.com>

RUN aurget libpng12
RUN pacman -U --noconfirm /aur/libpng12*.pkg.tar

RUN aurget lastpass-pocket
RUN pacman -U --noconfirm /aur/lastpass-pocket*.pkg.tar

RUN rm -rf /aur

ADD init.sh .
CMD ["sh", "init.sh"]
