ARG alpineversion

FROM alpine:${alpineversion}

ARG privatekey
ARG publickey

RUN test -n "$privatekey" -a -n "$publickey"

RUN apk --no-cache add abuild build-base jq

RUN adduser -D build
RUN addgroup build abuild
RUN mkdir -p /var/cache/distfiles
RUN chgrp abuild /var/cache/distfiles
RUN chmod g+w /var/cache/distfiles

RUN mkdir -p /home/build/.abuild/
COPY "$privatekey" /home/build/.abuild
COPY "$publickey" /home/build/.abuild
COPY "$publickey" /etc/apk/keys
RUN echo PACKAGER_PRIVKEY=\"/home/build/.abuild/${privatekey}\" > /home/build/.abuild/abuild.conf

RUN mkdir -p /home/build/digitalocean-alpine
COPY src/* /home/build/digitalocean-alpine/
RUN chown -R build:build /home/build

WORKDIR /home/build/digitalocean-alpine
CMD su build -- /usr/bin/abuild checksum && su build -- /usr/bin/abuild
