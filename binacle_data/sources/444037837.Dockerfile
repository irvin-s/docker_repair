FROM xeor/base-alpine:0.4
MAINTAINER Lars Solberg <lars.solberg@gmail.com>
ENV REFRESHED_AT 2018-01-29
EXPOSE 22

# Using py3-msgpack instead of pip install msgpack because the PiPY version
# is not optimized (it's pure python).

RUN apk update \
    && apk add --no-cache fuse libacl libattr lz4 openssl pkgconfig python3 openssh py3-msgpack lz4-dev \
    && apk add --no-cache --virtual .build-deps acl-dev attr-dev fuse-dev gcc musl-dev openssl-dev python3-dev linux-headers \
    && pip3 install borgbackup llfuse \
    && apk del .build-deps \
    && rm -f /etc/ssh/ssh_host_*

COPY root /
