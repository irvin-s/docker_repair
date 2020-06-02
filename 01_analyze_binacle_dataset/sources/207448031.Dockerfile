FROM gliderlabs/alpine:3.4
MAINTAINER jon morehouse <morehousej09@gmail.com>

EXPOSE 8000 8001 443 444

RUN apk --update add tar curl && \
	cd /usr/local/bin && \
	curl -L https://github.com/jonmorehouse/gatekeeper/releases/download/0.0.1/gatekeeper-0.0.1.linux-amd64.go1.6.2.tar.gz | tar zx && \
	rm -rf /var/cache/apk/*
