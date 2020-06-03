#####################
# Carbon Dockerfile #
# Alpine Linux Base #
#####################

FROM alpine:edge

MAINTAINER Adrian "vifino" Pistol

# Run the carbon repl by default!
ENTRYPOINT ["/usr/bin/carbon"]
CMD ["-repl"]

# Make /app a volume, for mounting for example `pwd` to easily run stuff.
VOLUME ["/app"]
WORKDIR /app

# Put the source in that directory.
COPY . /usr/local/go/src/github.com/carbonsrv/carbon

# Set the Go Path
ENV GOPATH /usr/local/go

RUN \
	echo http://dl-4.alpinelinux.org/alpine/edge/testing >> /etc/apk/repositories \
	&& apk update \
	&& apk upgrade \
	&& apk add --update \
		build-base git bash \
		luajit-dev physfs-dev \
		go \
	&& cd $GOPATH/src/github.com/carbonsrv/carbon && go get -t -d -v ./... \
	&& go build -v -o /usr/bin/carbon \
	&& strip --strip-all /usr/bin/carbon \
	&& rm -rf "$GOPATH" \
	&& apk del --purge \
		build-base go git \
	&& rm -rf /var/cache/apk/*

# Expose default ports.
EXPOSE 80
EXPOSE 443
