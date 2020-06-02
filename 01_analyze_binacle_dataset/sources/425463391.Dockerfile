FROM progrium/busybox
MAINTAINER Robert Xu <robxu9@gmail.com>

ADD ./build/docker-supervise /bin/docker-supervise

ENV DOCKER_HOST unix:///tmp/docker.sock

VOLUME ["/mnt/data"]

ENV PERSIST /mnt/data

EXPOSE 8080

ENTRYPOINT ["/bin/docker-supervise"]
CMD []
