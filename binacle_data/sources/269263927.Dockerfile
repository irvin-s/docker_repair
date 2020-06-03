# Using a 32bit Ubuntu image as we have to complile and use 32bit stuff here.
FROM ioft/i386-ubuntu:16.04

# Unlike ENV, ARG does not carry over into the image and only affects the build, which is what we want.
ARG DEBIAN_FRONTEND=noninteractive

# Basic packages and build dependencies
RUN apt-get update && apt-get -y --no-install-recommends install \
	ca-certificates \
	curl \
	# We will download and unzip archives from Github instead of installing and using git (saves a lot of space)
	unzip \
	gcc \
	make \
	# Build dependencies for libtunsock.a, ncsvc_preload.so and tncc_preload.so
	libevent-dev \
	libcap-dev \
	libpcap0.8-dev \
	# juniper-vpn-wrap.py and tncc.py wrapper dependencies
	python-dev \
	python-setuptools \
	python-pyasn1 \
	python-pyasn1-modules \
	libcurl4-openssl-dev \
	libssl-dev \
	libevent-dev \
	icedtea-plugin \
	# Cleanup
	&& apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

WORKDIR /root/.juniper_networks

# Build libtunsock.a
RUN curl -L https://github.com/russdill/lwip/archive/tap-via-socks.zip -o lwip.zip && \
	unzip -q lwip.zip && rm -f lwip.zip && cd lwip-tap-via-socks && \
	make

# Build ncsvc_preload.so and tncc_preload.so
ARG LWIP=/root/.juniper_networks/lwip-tap-via-socks
RUN curl -L https://github.com/russdill/ncsvc-socks-wrapper/archive/master.zip -o ncsvc-socks-wrapper.zip && \
	unzip -q ncsvc-socks-wrapper.zip && rm -f ncsvc-socks-wrapper.zip && cd ncsvc-socks-wrapper-master && \
	make install && \
	# Copy vpn and hostchecker wrapper scripts
	cp juniper-vpn-wrap.py /root/.juniper_networks && \
	cp tncc.py /root/.juniper_networks && \
	# Cleanup
	rm -rf /root/.juniper_networks/ncsvc-socks-wrapper-master /root/.juniper_networks/lwip-tap-via-socks

# Python juniper-vpn-wrap.py and tncc.py wrapper dependencies
RUN easy_install mechanize netifaces urlgrabber pycurl

# Proxy and helper binaries
RUN apt-get update && apt-get -y --no-install-recommends install \
	supervisor \
	socat \
	polipo \
	iputils-ping \
	dnsutils \
	# Cleanup
	&& apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Patched version of juniper-vpn-wrap.py
COPY juniper-vpn-wrap.py /root/.juniper_networks
# Sample configuration for juniper-vpn-wrap.py
COPY juniper-vpn-wrap.conf /root/.juniper_networks

COPY polipo.conf /etc/polipo/config
COPY supervisord.conf /etc/supervisor/conf.d/
COPY docker-entrypoint.sh /usr/local/bin/

ENTRYPOINT ["docker-entrypoint.sh"]

CMD ["supervisord"]

WORKDIR /root/.juniper_networks

EXPOSE 1080 8080
