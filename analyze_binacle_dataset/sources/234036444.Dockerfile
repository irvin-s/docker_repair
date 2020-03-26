FROM debian:wheezy

RUN apt-get update \
	&& apt-get install --no-install-recommends -y dpkg python2.7 sqlite3 \
        && apt-get autoremove -y \
	&& rm -rf /var/lib/apt/lists/*

VOLUME /build
