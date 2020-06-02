FROM paas/baseimage:1.0.0
MAINTAINER ZaneZeng

RUN \
	apt-get -y install curl && \
	wget --no-check-certificate "https://github.com/coreos/etcd/releases/download/v2.2.1/etcd-v2.2.1-linux-amd64.tar.gz" && \
	tar xzvf etcd-v2.2.1-linux-amd64.tar.gz && \
	rm etcd-v2.2.1-linux-amd64.tar.gz && \
	mv etcd-v2.2.1-linux-amd64 /etcd-2.2.1 && \ 
	ln -sf /etcd-2.2.1/etcd /usr/bin/etcd

ENV ETCD_DATA_DIR /var/lib/etcd

COPY docker-entrypoint.sh /docker-entrypoint.sh
RUN chmod a+x /docker-entrypoint.sh

EXPOSE 4001 7001 2379 2380

VOLUME ["${ETCD_DATA_DIR}"]

ENTRYPOINT ["tini", "--", "/docker-entrypoint.sh"]

CMD ["etcd"]