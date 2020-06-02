# Dockerfile for an Arch instance with stuff I need without X

FROM oddlid/arch-cli-minimal
MAINTAINER Odd E. Ebbesen <oddebb@gmail.com>

RUN pacman -S --noconfirm --needed \
		ansible \
		antiword \
		aspell \
		bc \
		bind-tools \
		bzr \
		cabextract \
		cdrkit \
		cpanminus \
		cpio \
		cvs \
		ddclient \
		dnsmasq \
		ed \
		elinks \
		fakeroot \
		fastjar \
		go \
		godep \
		html2text \
		htop \
		ipcalc \
		mc \
		mercurial \
		msmtp-mta \
		nmap \
		nodejs \
		nss \
		openbsd-netcat \
		openssh \
		p7zip \
		rpmextract \
		sipcalc \
		subversion \
		unace \
		unarj \
		unrar \
		unrtf \
		weechat \
		&& \
		rm -rf /var/cache/pacman/pkg/*

