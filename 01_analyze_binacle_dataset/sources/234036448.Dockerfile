FROM fedora:26

RUN dnf -y update \
	&& dnf install -y python sqlite-devel rpm-build rpmdevtools

VOLUME /build
