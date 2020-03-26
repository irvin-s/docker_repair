FROM debian:jessie

RUN apt-get update && \
    apt-get install -y fuse && \
    apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
    mkdir -p /data && mkdir -p /mdir

ADD weed /usr/bin/weed

ENTRYPOINT ["/usr/bin/weed"]
