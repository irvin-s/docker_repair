FROM balenalib/armv7hf-alpine:edge-build
LABEL io.balena.device-type="artik530"

RUN apk add --update \
		less \
		nano \
		net-tools \
		ifupdown \
		usbutils \
		gnupg \
	&& rm -rf /var/cache/apk/*