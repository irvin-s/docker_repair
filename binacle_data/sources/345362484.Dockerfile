FROM balenalib/armv7hf-fedora:26-build
LABEL io.balena.device-type="nanopi-neo-air"

RUN dnf install -y \
		less \
		nano \
		net-tools \
		usbutils \
		gnupg \
		i2c-tools \
	&& dnf clean all