FROM busybox:latest
MAINTAINER Alexis Montagne <alexis.montagne@gmail.com>

COPY etcdenv /etcdenv
COPY sensu-vulcand-client /sensu-vulcand-client

ENV SENSU_CLIENT_SUBSCRIPTIONS vulcand_check
ENV SENSU_CLIENT_NAME  sensu-vulcand-client

RUN chmod +x /etcdenv
RUN chmod +x /sensu-vulcand-client

ENV NAMESPACE /environments/sensu,/environments/global

CMD /etcdenv -n ${NAMESPACE} -s http://172.17.42.1:4001 /sensu-vulcand-client
