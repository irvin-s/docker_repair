FROM dockercask/base-xorg
MAINTAINER Zachary Huff <zach.huff.386@gmail.com>

RUN aurget tor-browser-en pgp.mit.edu 2E1AC68ED40814E0
RUN pacman -U --noconfirm /aur/tor-browser-en*.pkg.tar
RUN rm -rf /aur

ADD init.sh .
CMD ["sh", "init.sh"]
