FROM alpine:3.4

ARG ETCD_VERSION
ENV ETCD_VERSION=${ETCD_VERSION:-3.0.3}
RUN apk add --no-cache curl ca-certificates \
    && cd /tmp \
    && curl -L "https://github.com/coreos/etcd/releases/download/v${ETCD_VERSION}/etcd-v${ETCD_VERSION}-linux-amd64.tar.gz" | tar xzf - \
    && cp etcd-*/etcd /usr/bin \
    && cp etcd-*/etcdctl /usr/bin \
    && rm -rf "/tmp/"*

COPY docker-entrypoint.sh /entrypoint.sh

EXPOSE 2379 2380 4001

ENTRYPOINT ["/entrypoint.sh"]