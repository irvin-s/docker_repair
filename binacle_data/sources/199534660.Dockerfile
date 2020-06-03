FROM ubuntu:bionic

RUN apt-get update -qq
RUN apt-get install -yq --no-install-recommends \
	build-essential \
	debhelper \
	dpkg-dev \
	python3-all \
	python3-distutils-extra \
	po-debconf \
	pyflakes \
	lsb-release \
	gnu-efi
RUN mkdir -p /build/dell-recovery
WORKDIR /build/dell-recovery

CMD ["dpkg-buildpackage", "-tc", "-us", "-uc"]
