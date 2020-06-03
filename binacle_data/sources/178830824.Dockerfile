FROM busybox:latest
MAINTAINER Alexis Montagne <alexis.montagne@gmail.com>

COPY etcdenv /etcdenv
COPY sensu-aws-client /sensu-aws-client

ENV SENSU_CLIENT_SUBSCRIPTIONS aws_check
ENV SENSU_CLIENT_NAME  aws-check-client

RUN chmod +x /etcdenv
RUN chmod +x /sensu-aws-client

ENV NAMESPACE /environments/sensu,/environments/global

CMD /etcdenv -n ${NAMESPACE} -s http://172.17.42.1:4001 /sensu-aws-client
