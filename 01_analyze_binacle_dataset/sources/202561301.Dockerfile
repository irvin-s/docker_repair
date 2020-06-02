FROM openstf/armv7hf-stf

MAINTAINER Michael J. Mitchell <michael@mitchtech.net>

USER root

RUN apt-get update && apt-get install -y -q \
	android-tools* \
	ca-certificates \
	curl \
	usbutils \
	--no-install-recommends \
	&& rm -rf /var/lib/apt/lists/*

# Set up insecure default key
RUN mkdir -m 0750 /.android

ADD insecure_shared_adbkey /.android/adbkey
ADD insecure_shared_adbkey.pub /.android/adbkey.pub

WORKDIR /data

ENTRYPOINT [ "bash" ]

CMD ["stf", "local"]
