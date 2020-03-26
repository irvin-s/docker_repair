FROM busybox:latest

ADD https://github.com/upfluence/etcdenv/releases/download/v0.3.3/etcdenv-linux-amd64-0.3.3 \
  /etcdenv

COPY sensu-librato-handler /sensu-librato-handler

RUN chmod +x /etcdenv && \
  chmod +x /sensu-librato-handler

ENV NAMESPACE /environments/sensu,/environments/global

CMD /etcdenv -n ${NAMESPACE} -s http://172.17.42.1:4001 /sensu-librato-handler
