FROM balenalib/aarch64-fedora:26-run
LABEL io.balena.device-type="nanopc-t4"

RUN dnf install -y \
		less \
		nano \
		net-tools \
		usbutils \
		gnupg \
		i2c-tools \
	&& dnf clean all