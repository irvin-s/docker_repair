FROM base/archlinux:latest

MAINTAINER Roman Krivetsky <r.krivetsky@gmail.com>

RUN rm --recursive --force /etc/pacman.d/gnupg/* && \
	pacman-key --init && \
	pacman-key --populate archlinux && \
	pacman-key --refresh-keys && \
	pacman --sync --refresh --sysupgrade --noconfirm && \
	pacman-db-upgrade && \
	rm --recursive --force /tmp/* /var/cache/pacman/pkg/*

RUN pacman --sync --refresh --noconfirm \
		gzip grep sudo xdg-user-dirs && \
	rm --recursive --force /tmp/* /var/cache/pacman/pkg/*

ADD wheel /etc/sudoers.d/wheel

RUN useradd \
	--uid 1000 \
	--user-group \
	--groups wheel,users \
	--create-home \
	--password '$1$oZeWxk4p$yD7kDgmEEChHDRjoCDhuc.' \
	fellah

USER fellah

RUN xdg-user-dirs-update

VOLUME /home/fellah

WORKDIR /home/fellah

CMD bash
