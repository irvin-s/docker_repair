FROM balenalib/armv7hf-alpine:3.5-run
LABEL io.balena.device-type="ccon-01"

RUN apk add --update \
		less \
		nano \
		net-tools \
		ifupdown \
		usbutils \
		gnupg \
	&& rm -rf /var/cache/apk/*