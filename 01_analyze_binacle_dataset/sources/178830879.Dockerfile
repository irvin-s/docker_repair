FROM busybox:latest
MAINTAINER Philippe Ndiaye <philippe@upfluence.co>

COPY etcdenv /etcdenv
COPY flush_rabbit_queues /flush_rabbit_queues

RUN chmod +x /etcdenv
RUN chmod +x /flush_rabbit_queues

ENV NAMESPACE /environments/sensu,/environments/global

CMD /etcdenv -n ${NAMESPACE} -s http://172.17.42.1:4001 \
  /flush_rabbit_queues
