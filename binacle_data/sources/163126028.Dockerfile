FROM arm32v7/debian:stretch
LABEL vendor="Bayshore Networks" \
	com.bayshorenetworks.version="1.0" \
	com.bayshorenetworks.version.is-production="yes" \
	com.bayshorenetworks.release-date="2018-01-14"
ENV HOME /yextend
ENV TERM=vt102
ARG user=bayshore
ARG uid=1000
ARG gid=1000
RUN apt-get update && \
    apt-get install -y \
		wget \
		pkg-config \
		autoconf \
		make \
		zlib1g-dev \
		g++ \
		autoconf \
		libtool \
		zlib1g-dev \
		libssl-dev \
		libbz2-dev \
		libarchive13 \
		libarchive-dev \
		libpcre3-dev \
		uuid-dev \
		poppler-utils \
		python-nose \
	&& rm -rf /var/lib/apt/lists/*
RUN wget -O /tmp/v3.7.0.tar.gz https://github.com/VirusTotal/yara/archive/v3.7.0.tar.gz && \
	cd /tmp && \
	tar xfz v3.7.0.tar.gz && \
	cd yara-3.7.0 && \
	./bootstrap.sh && \
	./configure --prefix=/usr && \
	make && make install && \
	rm -rf v3.7.0*

ENV YEXTEND_HOME /yextend/
RUN groupadd -g $gid $user && \
	useradd -u $uid -g $gid $user
USER $user
