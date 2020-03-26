FROM dockercask/base-xorg
MAINTAINER Zachary Huff <zach.huff.386@gmail.com>

RUN pacman -S --noconfirm thunderbird

ADD init.sh .
CMD ["sh", "init.sh"]
