FROM golang:latest

MAINTAINER 'Josh Hawn <jlhawn@docker.com> (github:jlhawn)'

RUN apt-get update && \
    apt-get install -y zip

ENV PROJ_DIR /go/src/github.com/l0rd/docker-unit

ENV PLATFORMS '        \
	darwin/386     \
	darwin/amd64   \
	freebsd/386    \
	freebsd/amd64  \
	freebsd/arm    \
	linux/386      \
	linux/amd64    \
	linux/arm      \
	windows/386    \
	windows/amd64 \
'

RUN sh -c 'mkdir -p $PROJ_DIR'

COPY . $PROJ_DIR

RUN sh -c 'cp "$PROJ_DIR/scripts/make_binaries.sh" /usr/local/bin/make_binaries.sh'
RUN sh -c 'cp "$PROJ_DIR/scripts/make_tests.sh" /usr/local/bin/make_tests.sh'

ENTRYPOINT ["/usr/local/bin/make_binaries.sh"]
CMD ["/bundles"]

