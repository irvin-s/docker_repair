FROM balenalib/armv7hf-debian:stretch-build
LABEL io.balena.device-type="beaglebone-green-wifi"
RUN echo "deb [arch=armhf] http://repos.rcn-ee.net/debian/ stretch main" >> /etc/apt/sources.list \
	&& apt-key adv --batch --keyserver keyserver.ubuntu.com --recv-key D284E608A4C46402
RUN apt-get update && apt-get install -y --no-install-recommends \
		less \
		kmod \
		nano \
		net-tools \
		ifupdown \
		iputils-ping \
		i2c-tools \
		usbutils \
	&& rm -rf /var/lib/apt/lists/*