FROM debian:jessie

RUN apt-get update && apt-get install -y --no-install-recommends \
		binutils-arm-none-eabi \
		build-essential \
		ca-certificates \
		cmake \
		ctags \
		dfu-util \
		g++-multilib \
		gcc-arm-none-eabi \
		git \
		libusb-1.0-0-dev \
		libnewlib-arm-none-eabi \
		python3 \
	&& rm -rf /var/lib/apt/lists/* \
	&& git clone https://github.com/kiibohd/controller.git \
	&& mkdir /kiibohd \
	&& cd controller \
	&& mkdir first_compile \
	&& cd first_compile \
	&& cmake .. \
	&& make

VOLUME /kiibohd

COPY ./docker-entrypoint.sh /
ENTRYPOINT ["/docker-entrypoint.sh"]
