FROM alpine:3.1
MAINTAINER Eric Holmes <eric@remind101.com>

ENV DOCKER_HOST unix:///var/run/docker.sock

COPY ./ /go/src/github.com/remind101/dockerstats
COPY ./bin/build /build
RUN /build
WORKDIR /go/src/github.com/remind101/dockerstats

ENTRYPOINT ["stats"]
