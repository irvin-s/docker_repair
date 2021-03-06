ARG ARCH
FROM ${ARCH}/golang:1.8-stretch

COPY . /go/src/github.com/minio/minfs-docker-plugin
WORKDIR /go/src/github.com/minio/minfs-docker-plugin

RUN set -ex \
    && go install --ldflags '-extldflags "-static"'

CMD ["/go/bin/minfs-docker-plugin"]
