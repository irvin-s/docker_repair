FROM ubuntu:trusty
MAINTAINER Kevin Littlejohn <kevin@littlejohn.id.au>

# Fix the locale
RUN localedef -v -c -i en_US -f UTF-8 en_US.UTF-8 || :

# apt-get update because we _do_ need it :(
RUN apt-get -yq update

# Fake a fuse install
RUN apt-get install -yq apt-utils adduser libfuse2
RUN mkdir /tmp/fuse && \
	cd /tmp/fuse && \
	apt-get download fuse && \
	dpkg-deb -x fuse_* . && \
	dpkg-deb -e fuse_* && \
	rm fuse_*.deb && \
	echo -en '#!/bin/bash\nexit 0\n' > DEBIAN/postinst && \
	dpkg-deb -b . /fuse.deb && \
	dpkg -i /fuse.deb && \
	cd / && \
	rm -rf /tmp/fuse /fuse.deb

# Fix initctl, in case it hasn't been fixed already
RUN dpkg-divert --local --rename --add /sbin/initctl && rm -f /sbin/initctl && ln -s /bin/true /sbin/initctl

# Install some stuff I want by default
RUN apt-get -yq install git less vim wget socat tcpdump netcat unzip telnet

# Quick clean-up to reduce the size of this image
RUN apt-get clean

CMD ["/bin/bash"]
