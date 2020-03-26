FROM alpine:latest
MAINTAINER Antoine GIRARD <antoine.girard@sapk.fr>

ENV GOPATH=/go

RUN apk --no-cache --no-progress --force add \
          build-tools make gcc go musl-dev git ca-certificates dbus dbus-x11 gvfs gvfs-fuse gvfs-dav gvfs-smb openssh-client

ADD . ${GOPATH}/src/github.com/sapk/docker-volume-gvfs

RUN cd $GOPATH/src/github.com/sapk/docker-volume-gvfs && make build \
 && mv ./docker-volume-gvfs /usr/bin/docker-volume-gvfs \
 && cd && mkdir -p /var/lib/docker-volumes/gvfs /root/.ssh \
 && apk del --purge build-tools make gcc go musl-dev git \
 && rm -rf $GOPATH /var/cache/apk/*

ENTRYPOINT [ "/usr/bin/docker-volume-gvfs" ]
CMD [ "daemon" ]
