FROM alpine:edge
MAINTAINER support@kumina.nl

COPY birdwatcher.py /bin/birdwatcher

RUN echo http://nl.alpinelinux.org/alpine/edge/testing >> /etc/apk/repositories \
 && apk --update upgrade \
 && apk add bird python \
 && rm -rf /var/cache/apk/*

WORKDIR /
ENTRYPOINT ["/bin/birdwatcher"]
