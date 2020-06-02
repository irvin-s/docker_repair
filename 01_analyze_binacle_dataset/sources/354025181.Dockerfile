# @file Dockerfile
# @license The MIT License (MIT)
# @copyright 2016 Alex <alex@maximum.guru>

FROM ubuntu:16.04

MAINTAINER Alex <alex@maximum.guru>

# install alpine packages
RUN { \
	apt-get update && apt-get install -yq \
	bash \
	iptables \
	net-tools \
	iproute2 \
	inetutils-ping \
	lua5.1 \
	lua-filesystem \
	liblua5.1-0-dev \
	build-essential \
	luarocks \
	git \
	nodejs \
	python \
	linux-headers-generic \
	unzip \
	libsqlite3-dev \
	sqlite3 \
	kmod \
	psmisc \
	; \
}

RUN { \
	rm /bin/sh && \
	ln -s bash /bin/sh; \
}

# install lua dependencies
RUN { \
	luarocks install luasocket && \
	luarocks install cgilua && \
	luarocks install lua-cjson && \
	luarocks install inifile && \
	luarocks install xavante && \
	luarocks install wsapi-xavante && \
	luarocks install jsonrpc4lua && \
	luarocks install sha2 && \
	luarocks install bencode && \
	luarocks install dkjson && \
	luarocks install bit32 && \
	luarocks install alt-getopt && \
	luarocks install luaproc && \
	luarocks install luasql-sqlite3; \
}

WORKDIR /

# install cjdns
RUN { \
	git clone --depth=1 https://github.com/cjdelisle/cjdns.git -b cjdns-v20 && \
	cd cjdns && ./do && install -m755 -oroot -groot cjdroute /usr/sbin/cjdroute && \
	rm -rf /cjdns; \
}

# install container scripts
COPY ./docker/* /
COPY ./docker/transitd-cli /usr/sbin/transitd-cli

# install transitd and patch dependencies
COPY ./src/ /transitd/src/
COPY ./transitd.conf.sample /transitd/transitd.conf.sample
COPY ./patches/ /transitd/patches/
RUN { \
	patch -p0 /usr/local/share/lua/5.1/socket/http.lua /transitd/patches/luasocket-ipv6-fix.patch && \
	patch -p0 /usr/local/share/lua/5.1/cgilua/post.lua /transitd/patches/cgilua-content-type-fix.patch; \
}

# cleanup
RUN { \
	apt-get purge -y --auto-remove liblua5.1-0-dev build-essential luarocks git nodejs python linux-headers-generic unzip libsqlite3-dev; \
	apt-get autoremove; \
	apt-get clean; \
	rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*; \
}

CMD ["/start.sh"]
EXPOSE 65533
