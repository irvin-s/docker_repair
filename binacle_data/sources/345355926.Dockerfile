FROM balenalib/armv7hf-fedora:29-run
LABEL io.balena.device-type="artik533s"

RUN dnf install -y \
		less \
		nano \
		net-tools \
		usbutils \
		gnupg \
		i2c-tools \
	&& dnf clean all