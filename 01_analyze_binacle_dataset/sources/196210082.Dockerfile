FROM dockercask/base-xorg
MAINTAINER Zachary Huff <zach.huff.386@gmail.com>

RUN pacman -S --noconfirm nss

RUN aurget slack-desktop
RUN pacman -U --noconfirm /aur/slack-desktop*.pkg.tar
RUN rm -rf /aur

# memlock limit cannot be used in a docker container
RUN rm /etc/security/limits.d/10-gcr.conf

ADD init.sh .
CMD ["sh", "init.sh"]
