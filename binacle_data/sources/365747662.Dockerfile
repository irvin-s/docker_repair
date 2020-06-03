FROM scratch
MAINTAINER Jan Broer <janeczku@yahoo.com>

ADD binaries/etcd-v0.4.9-patched-linux-armv7 /bin/etcd

VOLUME ["/data"]

EXPOSE 4001 7001

ENTRYPOINT ["/bin/etcd"]

CMD ["-data-dir=/data"]
