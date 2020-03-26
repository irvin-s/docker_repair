FROM busybox:latest
MAINTAINER Alexis Montagne <alexis.montagne@gmail.com>

COPY etcdenv /etcdenv
COPY sensu-thrift-client /sensu-thrift-client

ENV SENSU_CLIENT_SUBSCRIPTIONS thrift_check
ENV SENSU_CLIENT_NAME  thrift-check-client

RUN chmod +x /etcdenv
RUN chmod +x /sensu-thrift-client

ENV NAMESPACE /environments/sensu

CMD /etcdenv -n ${NAMESPACE} -s http://172.17.42.1:4001 /sensu-thrift-client
