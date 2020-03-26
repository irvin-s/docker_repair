FROM debian:stable

# Buildroot deps
RUN apt-get update && apt-get install -y \
	bc \
	bzip2 \
	cpio \
	file \
	gcc \
	g++ \
	git \
	gzip \
	make \
	ncurses-dev \
	python \
	unzip \
	wget \
	autotools-dev \
	automake \
	libtool

WORKDIR /root
RUN wget https://buildroot.org/downloads/buildroot-2017.08.tar.gz
RUN tar zxvf buildroot-2017.08.tar.gz && mv buildroot-2017.08 buildroot-precompiled-2017.08

WORKDIR /root/buildroot-precompiled-2017.08
COPY users.tables /root/buildroot-precompiled-2017.08/users.tables
COPY defconfig /root/buildroot-precompiled-2017.08/configs/embsys_defconfig
COPY busybox.config /root/buildroot-precompiled-2017.08/busybox.config

RUN make embsys_defconfig && make && rm -rf dl/* && find output/build/ -maxdepth 1 ! -name rpi-firmware-685b3ceb0a6d6d6da7b028ee409850e83fb7ede7 -exec rm -rfv {} \;

WORKDIR /root
RUN tar zcvf buildroot-precompiled-2017.08.tar.gz buildroot-precompiled-2017.08
