#######################
#  Carbon Dockerfile  #
# Ubuntu Golang Base. #
#######################

FROM golang

MAINTAINER Adrian "vifino" Pistol

# Run the carbon repl by default!
ENTRYPOINT ["/go/bin/carbon"]
CMD ["-repl"]

# Make /app a volume, for mounting for example `pwd` to easily run stuff.
VOLUME ["/app"]
WORKDIR /app

RUN \
	apt-get update && apt-get install -y --no-install-recommends \
		git \
		pkgconf \
		libluajit-5.1-dev \
		libphysfs-dev \
		upx \
	&& rm -rf /var/lib/apt/lists/* \
	&& mkdir -p /go/src/github.com/carbonsrv \
	&& git clone http://github.com/carbonsrv/carbon.git /go/src/github.com/carbonsrv/carbon \
	&& cd /go/src/github.com/carbonsrv/carbon && go get -t -d -v ./... \
	&& go build -v -o /usr/bin/carbon \
	&& strip --strip-all /usr/bin/carbon \
	&& rm -rf "$GOPATH" \
	&& upx -9 /usr/bin/carbon \
	&& apt-get remove -y pkgconf upx

# Expose default ports.

EXPOSE 80
EXPOSE 443
