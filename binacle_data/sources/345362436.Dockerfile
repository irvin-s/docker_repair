FROM balenalib/aarch64-alpine:edge-build
LABEL io.balena.device-type="nanopc-t4"

RUN apk add --update \
		less \
		nano \
		net-tools \
		ifupdown \
		usbutils \
		gnupg \
	&& rm -rf /var/cache/apk/*