FROM busybox:latest
MAINTAINER Julien Levesy<julien@upfluence.co>

ADD https://github.com/upfluence/etcdenv/releases/download/v0.3.3/etcdenv-linux-amd64-0.3.3 \
  /etcdenv
COPY sensu-metrics-client /sensu-metrics-client

ENV SENSU_CLIENT_SUBSCRIPTIONS metrics-collection
ENV SENSU_CLIENT_NAME sensu-metrics-client
ENV ETCD_URL "http://172.17.42.1:2379"

RUN chmod +x /etcdenv && \
  chmod +x /sensu-metrics-client

CMD /etcdenv -n /environments/sensu \
  -w RABBITMQ_URL \
  -s http://172.17.42.1:4001 \
  /sensu-metrics-client
