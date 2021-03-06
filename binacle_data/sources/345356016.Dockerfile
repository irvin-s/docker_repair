FROM balenalib/armv7hf-alpine:3.7-run
LABEL io.balena.device-type="asus-tinker-board"

RUN apk add --update \
		less \
		nano \
		net-tools \
		ifupdown \
		usbutils \
		gnupg \
	&& rm -rf /var/cache/apk/*