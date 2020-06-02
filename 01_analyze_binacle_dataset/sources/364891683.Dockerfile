FROM debian:stable
ENV DEBIAN_FRONTEND noninteractive

# Buildroot deps
RUN apt-get update && apt-get install -y \
	git \
	python \
	python3 \
	gcc \
	g++ \
	gawk \
	texinfo \
	make \
	diffstat \
	chrpath \
	wget \
	cpio \
	locales

RUN echo "en_US.UTF-8 UTF-8" > /etc/locale.gen && \
    locale-gen en_US.UTF-8 && \
    dpkg-reconfigure locales && \
    /usr/sbin/update-locale LANG=en_US.UTF-8
ENV LC_ALL en_US.UTF-8

RUN adduser user  # for running bitbake
USER user

WORKDIR /home/user/
RUN git clone -b thud git://git.yoctoproject.org/poky.git poky-thud-precompiled

WORKDIR /home/user/poky-thud-precompiled
RUN git clone -b thud git://git.yoctoproject.org/meta-raspberrypi
COPY build.sh build.sh
RUN sh build.sh

RUN rm -r build/tmp/sysroots-components/
RUN rm -r build/tmp/work/
RUN rm -r build/tmp/work-shared/
RUN rm -r build/downloads/
RUN rm -r build/sstate-cache/
RUN rm -r build/tmp/sysroots-uninative/
RUN rm -r build/tmp/log/
RUN rm -r build/tmp/pkgdata/
RUN rm -r build/tmp/stamps/
RUN rm -r build/tmp/buildstats/
RUN rm -r build/tmp/cache/
RUN rm -r build/tmp/deploy/rpm/

WORKDIR /home/user
RUN tar zcvf poky-thud-precompiled.tar.gz poky-thud-precompiled

USER root
