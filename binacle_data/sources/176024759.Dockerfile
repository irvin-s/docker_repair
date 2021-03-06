FROM boot2docker
MAINTAINER Sven Dowideit "SvenDowideit@docker.com"

#DESCRIPTION use the nightly testing build of Docker

#get the latest testing docker
RUN curl -L -o $ROOTFS/usr/local/bin/docker https://test.docker.io/builds/Linux/x86_64/docker-latest && \
    chmod +x $ROOTFS/usr/local/bin/docker

RUN echo "  WARNING: this is a test.docker.io build, not a release." >> $ROOTFS/etc/motd
RUN echo "" >> $ROOTFS/etc/motd

RUN /make_iso.sh
CMD ["cat", "boot2docker.iso"]
