FROM balenalib/aarch64-fedora:30-run
LABEL io.balena.device-type="jetson-tx1"

RUN dnf install -y \
		less \
		nano \
		net-tools \
		usbutils \
		gnupg \
		i2c-tools \
	&& dnf clean all