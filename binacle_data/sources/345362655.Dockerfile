FROM balenalib/armv7hf-alpine:edge-run
LABEL io.balena.device-type="odroid-xu4"

RUN apk add --update \
		less \
		nano \
		net-tools \
		ifupdown \
		usbutils \
		gnupg \
	&& rm -rf /var/cache/apk/*