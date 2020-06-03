FROM busybox:latest
MAINTAINER Alexis Montagne <alexis.montagne@gmail.com>

COPY etcdenv /etcdenv
COPY sensu-http-client /sensu-http-client

ENV SENSU_CLIENT_SUBSCRIPTIONS http_check
ENV SENSU_CLIENT_NAME  sensu-http-client

RUN chmod +x /etcdenv
RUN chmod +x /sensu-http-client

ENV NAMESPACE /environments/sensu,/environments/global

CMD /etcdenv -n ${NAMESPACE} -s http://172.17.42.1:4001 /sensu-http-client
