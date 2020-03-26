# we don't want to use quay.io/coreos/etcd because they only ship the `etcd` and
# `etcdctl` binaries in a scratch container
FROM alpine:3.5

RUN apk --no-cache \
    add \
        bash \
        ca-certificates \
        curl \
        jq

ENV ETCD_VERSION v3.2.0
ENV RELEASE_URL https://github.com/coreos/etcd/releases/download
# get etcd release
RUN export ETCD_CHECKSUM=a26c7de7994d295541bf20f6e09f7e6afa81c45b \
    && curl -Lso /tmp/etcd.tar.gz \
         "${RELEASE_URL}/${ETCD_VERSION}/etcd-${ETCD_VERSION}-linux-amd64.tar.gz" \
    && echo "${ETCD_CHECKSUM}  /tmp/etcd.tar.gz" | sha1sum -c \
    && tar zxf /tmp/etcd.tar.gz -C /tmp \
    && mv /tmp/etcd-${ETCD_VERSION}-linux-amd64/etcd* /usr/local/bin/

#COPY etc/etcd.json etc/etcd/
COPY bin/* /usr/local/bin/

EXPOSE 2379 2380 4001

ENV SHELL /bin/bash
