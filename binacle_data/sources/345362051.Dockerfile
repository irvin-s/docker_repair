FROM balenalib/armv7hf-fedora:28-run
LABEL io.balena.device-type="imx7-var-som"

RUN dnf install -y \
		less \
		nano \
		net-tools \
		usbutils \
		gnupg \
		i2c-tools \
	&& dnf clean all