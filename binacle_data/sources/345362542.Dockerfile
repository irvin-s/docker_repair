FROM balenalib/armv7hf-alpine:3.8-build
LABEL io.balena.device-type="nitrogen6xq2g"

RUN apk add --update \
		less \
		nano \
		net-tools \
		ifupdown \
		usbutils \
		gnupg \
	&& rm -rf /var/cache/apk/*