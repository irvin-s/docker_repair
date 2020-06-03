FROM alpine

ADD https://get.docker.com/builds/Linux/x86_64/docker-latest /usr/bin/docker
RUN chmod 755 /usr/bin/docker

ENTRYPOINT ["/usr/bin/docker"]
