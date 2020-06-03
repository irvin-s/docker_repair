# Arch Linux ARM (Raspberry Pi 2)

FROM scratch AS armhf-archlinux

MAINTAINER TokinRing <support@gnetsolutions.net>
LABEL Description="Arch Linux ARM (Raspberry Pi 2)" Repository="armv7/armhf-archlinux"

ADD http://os.archlinuxarm.org/os/ArchLinuxARM-rpi-2-latest.tar.gz /

RUN pacman -Sy --noconfirm mariadb{-clients,} && pacman -Scc --noconfirm

CMD /usr/sbin/mysql
