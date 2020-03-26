from pritunl/archlinux

## INSTALL YAOURT

RUN pacman -Syu --noconfirm && \
    pacman -S base-devel --noconfirm && \
    pacman -S --noconfirm git sudo

RUN groupadd -r work && \
    useradd -r -g work work && \
    echo "work ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

RUN mkdir /tmp/yaourt && \
    chown -R work:work /tmp/yaourt

RUN mkdir /home/work && chown work /home/work

USER work

RUN cd /tmp/yaourt && \
    git clone https://aur.archlinux.org/package-query.git && \
    cd package-query && \
    makepkg --noconfirm -si

RUN cd /tmp/yaourt && \
    git clone https://aur.archlinux.org/yaourt.git && \
    cd yaourt && \
    makepkg --noconfirm -si

USER root

RUN alias 'yaourt=sudo -i -u work yaourt'

COPY din /din
