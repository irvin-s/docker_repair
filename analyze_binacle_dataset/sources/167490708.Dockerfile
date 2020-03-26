FROM progrium/busybox
MAINTAINER Jeff Lindsay <progrium@gmail.com>

ADD https://get.docker.io/builds/Linux/x86_64/docker-1.2.0 /bin/docker
RUN chmod +x /bin/docker
