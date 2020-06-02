#####################
# Carbon Dockerfile #
# Alpine Torch Base #
#####################

FROM vifino/torch

MAINTAINER Adrian "vifino" Pistol

# Run the carbon repl by default!
ENTRYPOINT ["/usr/bin/carbon"]
CMD ["/torch/lib/luarocks/rocks/trepl/scm-1/bin/th "]

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
		git bash \
		physfs-dev \
		go \
	&& cd $GOPATH/src/github.com/carbonsrv/carbon && go get -t -d -v ./... \
	&& go build -v -o /usr/bin/carbon \
	&& strip --strip-all /usr/bin/carbon \
	&& echo -e "#!/bin/sh\nexec carbon /torch/lib/luarocks/rocks/trepl/scm-1/bin/th \"\$@\"" | tee /torch/bin/th \
	&& sed -i 's/local parg = arg/local parg = arg or args/' /torch/lib/luarocks/rocks/trepl/scm-1/bin/th \
	&& rm -rf "$GOPATH" \
	&& apk del --purge \
		go \
	&& rm -rf /var/cache/apk/*

# Expose default ports.
EXPOSE 80
EXPOSE 443
