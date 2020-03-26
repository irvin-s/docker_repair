FROM busybox:latest
MAINTAINER Alexis Montagne <alexis.montagne@gmail.com>

COPY etcdenv /etcdenv
COPY sensu-elasticsearch-client /sensu-elasticsearch-client

ENV SENSU_CLIENT_SUBSCRIPTIONS elasticsearch_check
ENV SENSU_CLIENT_NAME  sensu-elasticsearch-client

RUN chmod +x /etcdenv
RUN chmod +x /sensu-elasticsearch-client

ENV NAMESPACE /environments/sensu,/environments/global

CMD /etcdenv -n ${NAMESPACE} -s http://172.17.42.1:4001 /sensu-elasticsearch-client
