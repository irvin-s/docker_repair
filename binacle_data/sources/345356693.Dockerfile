FROM balenalib/aarch64-alpine:3.8-build
LABEL io.balena.device-type="raspberrypi3-64"

RUN apk add --update \
		less \
		nano \
		net-tools \
		ifupdown \
		usbutils \
		gnupg \
	&& rm -rf /var/cache/apk/*