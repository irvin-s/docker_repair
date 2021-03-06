FROM balenalib/aarch64-alpine:edge-build
LABEL io.balena.device-type="srd3-tx2"

RUN apk add --update \
		less \
		nano \
		net-tools \
		ifupdown \
		usbutils \
		gnupg \
	&& rm -rf /var/cache/apk/*