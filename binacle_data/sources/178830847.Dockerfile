FROM busybox:latest
MAINTAINER Alexis Montagne <alexis.montagne@gmail.com>

COPY etcdenv /etcdenv
COPY sensu-postgres-client /sensu-postgres-client

ENV SENSU_CLIENT_SUBSCRIPTIONS postgres_check
ENV SENSU_CLIENT_NAME  sensu-postgres-client

RUN chmod +x /etcdenv
RUN chmod +x /sensu-postgres-client

ENV NAMESPACE /environments/sensu,/environments/global

CMD /etcdenv -n ${NAMESPACE} -s http://172.17.42.1:4001 /sensu-postgres-client
