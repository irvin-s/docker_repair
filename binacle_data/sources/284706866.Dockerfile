###############################################################################
#  Build the mysql-oerator related binaries
###############################################################################
FROM golang:1.11.2 as builder

# Copy in the go src
WORKDIR /go/src/github.com/presslabs/mysql-operator
COPY pkg/    pkg/
COPY cmd/    cmd/
COPY vendor/ vendor/

# Build
RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -a -o mysql-operator github.com/presslabs/mysql-operator/cmd/mysql-operator
RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -a -o mysql-operator-sidecar github.com/presslabs/mysql-operator/cmd/mysql-operator-sidecar
RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -a -o orc-helper github.com/presslabs/mysql-operator/cmd/orc-helper

##############################################################################
#  Build Orchestrator
###############################################################################
FROM golang:1.9-alpine as builder-orc

RUN set -ex \
    && apk add --no-cache \
        bash gcc git musl-dev openssl rsync

ARG ORCHESTRATOR_VERSION=v3.0.14
ARG ORCHESTRATOR_REPO=https://github.com/github/orchestrator.git
RUN set -ex \
    && mkdir -p $GOPATH/src/github.com/github/orchestrator \
    && cd $GOPATH/src/github.com/github/orchestrator \
    && git init && git remote add origin $ORCHESTRATOR_REPO \
    && git fetch --tags \
    && git checkout $ORCHESTRATOR_VERSION

WORKDIR $GOPATH/src/github.com/github/orchestrator

RUN set -ex \
    && ls -l \
    && ./script/build

###############################################################################
#  Docker image for orchestrator
###############################################################################
FROM alpine:3.7

# Create a group and user
RUN addgroup -g 777 orchestrator && adduser -u 777 -g 777 -S orchestrator

ENV DOCKERIZE_VERSION v0.6.1
RUN set -ex \
    && apk add --update --no-cache \
        curl \
        wget \
        tar \
        openssl \
    && mkdir /etc/orchestrator /var/lib/orchestrator \
    && chown -R 777:777 /etc/orchestrator /var/lib/orchestrator \
    && wget https://github.com/jwilder/dockerize/releases/download/$DOCKERIZE_VERSION/dockerize-alpine-linux-amd64-$DOCKERIZE_VERSION.tar.gz -O- | \
        tar -C /usr/local/bin -xzv

COPY --chown=777:777 hack/docker/orchestrator/ /
COPY --from=builder-orc /go/src/github.com/github/orchestrator/bin/ /usr/local/orchestrator/
COPY --from=builder /go/src/github.com/presslabs/mysql-operator/orc-helper /usr/local/bin/

USER 777
EXPOSE 3000 10008
VOLUME [ "/var/lib/orchestrator" ]

ENTRYPOINT ["/usr/local/bin/docker-entrypoint"]
CMD ["/usr/local/bin/orchestrator", "-quiet", "-config", "/etc/orchestrator/orchestrator.conf.json", "http"]