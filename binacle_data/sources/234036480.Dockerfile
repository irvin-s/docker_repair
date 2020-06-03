FROM ubuntu:zesty

RUN perl -i -pe 's#archive.ubuntu.com#old-releases.ubuntu.com#g' /etc/apt/sources.list && \
	perl -i -pe 's#security.ubuntu.com#old-releases.ubuntu.com#g' /etc/apt/sources.list

RUN apt-get update \
	&& apt-get install --no-install-recommends -y dpkg python2.7 sqlite3 \
        && apt-get autoremove -y \
	&& rm -rf /var/lib/apt/lists/*

VOLUME /build
