FROM java:8
MAINTAINER Luis Arias <luis@balsamiq.com>

RUN \
  apt-get update && \
  apt-get -y upgrade && apt-get -y install curl wget supervisor cron

# Install elasticsearch

WORKDIR /opt
RUN wget --no-check-certificate -O- https://download.elasticsearch.org/elasticsearch/elasticsearch/elasticsearch-1.4.4.tar.gz | tar xvfz -
RUN mv elasticsearch-1.4.4 elasticsearch

# Install elasticsearch cloud aws plugin
RUN cd elasticsearch && bin/plugin -install elasticsearch/elasticsearch-cloud-aws/2.4.1

ENV ES_CLUSTER_NAME elasticsearch
ENV ES_AWS_REGION us-east-1

EXPOSE 9200 9300

ADD es_rotate /opt/es_rotate
RUN chmod +x /opt/es_rotate

ADD es.crontab /opt/es.crontab
RUN crontab /opt/es.crontab

ADD supervisord.conf /etc/supervisor/conf.d/elasticsearch.conf

ADD run ./run
RUN chmod +x ./run
CMD ./run
