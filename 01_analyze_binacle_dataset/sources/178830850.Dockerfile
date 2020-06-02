FROM busybox:latest
MAINTAINER Alexis Montagne <alexis.montagne@gmail.com>

COPY etcdenv /etcdenv
COPY sensu-rabbitmq-client /sensu-rabbitmq-client

ENV SENSU_CLIENT_SUBSCRIPTIONS rabbitmq_check
ENV SENSU_CLIENT_NAME  sensu-rabbitmq-client

RUN chmod +x /etcdenv
RUN chmod +x /sensu-rabbitmq-client

ENV NAMESPACE /environments/sensu,/environments/global

CMD /etcdenv -n ${NAMESPACE} -s http://172.17.42.1:4001 /sensu-rabbitmq-client
