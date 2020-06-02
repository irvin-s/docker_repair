FROM lsiobase/alpine:3.9

RUN \
 echo "**** install build packages ****" && \
 apk add --no-cache --virtual=build-dependencies \
	autoconf \
	automake \
	freetype-dev \
	g++ \
	gcc \
	jpeg-dev \
	lcms2-dev \
	libffi-dev \
	libpng-dev \
	libwebp-dev \
	linux-headers \
	make \
	openjpeg-dev \
	openssl-dev \
	python2-dev \
	tiff-dev \
	zlib-dev && \
 echo "**** install runtime packages ****" && \
 apk add --no-cache \
	curl \
	freetype \
	git \
	lcms2 \
	libjpeg-turbo \
	libwebp \
	openjpeg \
	openssl \
	p7zip \
	py2-lxml \
	py2-pip \
	python2 \
	tar \
	tiff \
	unrar \
	unzip \
	vnstat \
	wget \
	xz \
	zlib && \
 echo "**** install pip packages ****" && \
 pip install --no-cache-dir -U \
	pip && \
 pip install -U \
	cheetah \
	configparser \
	ndg-httpsclient \
	notify \
	paramiko \
	pillow \
	psutil \
	pyopenssl \
	requests \
	setuptools \
	urllib3 \
	virtualenv && \
 echo "**** clean up ****" && \
 apk del --purge \
	build-dependencies && \
 rm -rf \
	/root/.cache \
	/tmp/*
