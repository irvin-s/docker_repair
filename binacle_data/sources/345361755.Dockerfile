FROM balenalib/armv7hf-alpine:edge-run
LABEL io.balena.device-type="colibri-imx6dl"

RUN apk add --update \
		less \
		nano \
		net-tools \
		ifupdown \
		usbutils \
		gnupg \
	&& rm -rf /var/cache/apk/*