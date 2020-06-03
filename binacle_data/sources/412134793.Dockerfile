### Dockerfile
#
#   See https://github.com/russmckendrick/docker

FROM russmckendrick/base:latest
MAINTAINER Russ McKendrick <russ@mckendrick.io>

ENV TERM dumb
ENV SIPVICIOUS_VERSION 0.2.8

RUN apk add --update python openssl \
	&& rm -rf /var/cache/apk/* \
	&& mkdir -p /app/ \
	&& wget https://github.com/sandrogauci/sipvicious/archive/v$SIPVICIOUS_VERSION.tar.gz \
	&& tar -xvzf v$SIPVICIOUS_VERSION.tar.gz \
	&& mv sipvicious-$SIPVICIOUS_VERSION/* /app \
	&& rm -rf sipvicious-$SIPVICIOUS_VERSION \
	&& rm v$SIPVICIOUS_VERSION.tar.gz

WORKDIR /app/

ENTRYPOINT ["/app/svmap.py"]
CMD ["--help"]