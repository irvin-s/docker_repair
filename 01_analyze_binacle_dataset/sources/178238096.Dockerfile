FROM oddlid/debian-base:stretch
MAINTAINER Odd E. Ebbesen <oddebb@gmail.com>

ENV ZNC_VERSION 1.7.1

RUN apt-get update -qq --fix-missing \
	&& \
	apt-get install -y --no-install-recommends \
	libcurl4-openssl-dev \
	libicu-dev \
	libperl-dev \
	libsasl2-dev \
	libssl-dev \
	pkg-config \
	&& \
	apt-get clean autoclean \
	&& \
	apt-get autoremove -y \
	&& \
	rm -rf /var/lib/{apt,dpkg,cache,log}/ /tmp/* /var/tmp/* \
	&& \
	mkdir -p /src

RUN cd /src \
	&& \
	curl -O https://znc.in/releases/znc-${ZNC_VERSION}.tar.gz \
	&& \
	tar -zxf znc-${ZNC_VERSION}.tar.gz \
	&& \
	cd znc-${ZNC_VERSION} \
	&& \
	./configure --enable-perl --enable-cyrus \
	&& \
	make -j $(nproc) \
	&& \
	make -j $(nproc) install \
	&& \
	cd - \
	&& \
	rm -rf znc-${ZNC_VERSION}*

RUN useradd -u 1000 -U znc
COPY start-znc /usr/local/bin/
COPY znc.conf.default /src/

EXPOSE 6664 6665 6666 6667
VOLUME ["/znc-data"]
CMD ["start-znc"]

