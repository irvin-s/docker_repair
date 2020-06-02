FROM paas/baseimage:1.0.0
MAINTAINER ZaneZeng

ENV ETCD_DATA_DIR /var/lib/etcd
ENV LOG_PATH /var/log/kubernete

COPY etcd /etcd-2.2.1
COPY kubenetes /kubenetes-1.1.2
COPY docker-entrypoint.sh /docker-entrypoint.sh

RUN \
    ln -sf /etcd-2.2.1/etcd /usr/bin/etcd && \
    ln -sf /kubenetes-1.1.2/km /usr/bin/km && \
    chmod a+x /docker-entrypoint.sh

EXPOSE 4001 8080 10250 

VOLUME ["${ETCD_DATA_DIR}"]
VOLUME ["${LOG_PATH}"]

ENTRYPOINT ["tini", "--", "/docker-entrypoint.sh"]

CMD ["/bin/bash"]