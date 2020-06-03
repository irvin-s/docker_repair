FROM paas/baseimage:1.0.0
MAINTAINER ZaneZeng

RUN \
	apt-get -y install curl && \
	wget --no-check-certificate "https://github.com/coreos/etcd/releases/download/v2.2.1/etcd-v2.2.1-linux-amd64.tar.gz" && \
	tar xzvf etcd-v2.2.1-linux-amd64.tar.gz && \
	rm etcd-v2.2.1-linux-amd64.tar.gz && \
	mv etcd-v2.2.1-linux-amd64 etcd-2.2.1 && \ 
	ln -sf `pwd`/etcd-2.2.1/etcd /usr/bin/etcd

ENV ETCD_DATA_DIR /var/lib/etcd
ENV LOG_PATH /var/log
ENV MASTER_PATH /kube-master-1.1.2
ENV WORKER_PATH /kube-worker-1.1.2

COPY master /kube-master-1.1.2
COPY worker /kube-worker-1.1.2
COPY ui /kube-ui-2.0.0
COPY dns /skydns
COPY docker-entrypoint.sh /docker-entrypoint.sh

RUN chmod -R a+x /skydns
RUN chmod a+x /docker-entrypoint.sh
RUN chmod -R a+x /kube-master-1.1.2
RUN chmod -R a+x /kube-worker-1.1.2

EXPOSE 4001 7001 2379 2380 8080

VOLUME ["${ETCD_DATA_DIR}"]
VOLUME ["${LOG_PATH}"]

ENTRYPOINT ["tini", "--", "/docker-entrypoint.sh"]

CMD ["/bin/bash"]