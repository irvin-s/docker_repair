FROM golang:1.5

ADD . /go/src/github.com/fiorix/defacer
WORKDIR /go/src/github.com/fiorix/defacer

RUN  \
echo deb http://httpredir.debian.org/debian jessie main > /etc/apt/sources.list ; \
echo deb http://httpredir.debian.org/debian jessie-updates main >> /etc/apt/sources.list ; \
echo deb http://security.debian.org/ jessie/updates main >> /etc/apt/sources.list ; \
apt-get update ; \
apt-get install -y \
	build-essential \
	libopencv-calib3d2.4 \
	libopencv-contrib2.4 \
	libopencv-core2.4 \
	libopencv-dev \
	libopencv-imgproc2.4 \
	libopencv-ocl2.4 \
	libopencv-stitching2.4 \
	libopencv-superres2.4 \
	libopencv-ts2.4 \
	libopencv-videostab2.4 ; \
GO15VENDOREXPERIMENT=1 go install ; \
apt-get autoremove -y --purge \
	'.*-dev$' \
	binutils \
	build-essential \
	cpp \
	g++ \
	gcc \
	gcc-4.8-base \
	i965-va-driver \
	libopencv-dev \
	make \
	perl \
	python \
	va-driver-all \
	vdpau-va-driver ; \
apt-get clean ; \
rm -rf /var/lib/apt/lists/* ; \
rm -rf /usr/share/doc/* ; \
rm -rf /usr/share/man/* ; \
rm -rf /usr/share/locale/* ; \
rm -rf /usr/local/go

ENTRYPOINT ["/go/bin/defacer"]
