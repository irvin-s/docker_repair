FROM balenalib/aarch64-alpine:edge-run
LABEL io.balena.device-type="n510-tx2"

RUN apk add --update \
		less \
		nano \
		net-tools \
		ifupdown \
		usbutils \
		gnupg \
	&& rm -rf /var/cache/apk/*