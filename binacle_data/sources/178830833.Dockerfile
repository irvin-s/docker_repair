FROM busybox:latest
MAINTAINER Alexis Montagne <alexis.montagne@gmail.com>

COPY etcdenv /etcdenv
COPY sensu-fleet-client /sensu-fleet-client

ENV SENSU_CLIENT_SUBSCRIPTIONS fleet_check
ENV SENSU_CLIENT_NAME  sensu-fleet-client

RUN chmod +x /etcdenv
RUN chmod +x /sensu-fleet-client

ENV NAMESPACE /environments/sensu,/environments/global
ENV ETCD_URL http://172.17.42.1:4001

CMD /etcdenv -n ${NAMESPACE} -s http://172.17.42.1:4001 /sensu-fleet-client
