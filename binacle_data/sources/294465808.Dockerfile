FROM ubuntu:xenial

ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update -y && apt-get install -y \
	cmake \
	dpkg-dev \
	g++ \
	git \
	libboost-atomic1.58-dev \
	libboost-chrono1.58-dev \
	libboost-date-time1.58-dev \
	libboost-filesystem1.58-dev \
	libboost-program-options1.58-dev \
	libboost-regex1.58-dev \
	libboost-system1.58-dev \
	libboost-thread1.58-dev \
	libboost-timer1.58-dev \
	libboost1.58-dev \
	libssl-dev \
	libyajl-dev \
	make \
    && rm -rf /var/lib/apt/lists/*
