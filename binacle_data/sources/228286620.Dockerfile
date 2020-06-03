FROM logstash:2.3.4-1
MAINTAINER Peter Schmitt <peter.schmitt@digitalglobe.com>

RUN /opt/logstash/bin/logstash-plugin install logstash-output-amazon_es
RUN /opt/logstash/bin/logstash-plugin install logstash-patterns-core

COPY conf /etc/logstash/conf.d
COPY start_logstash.sh /
RUN chmod +x /start_logstash.sh

ENV AWS_REGION "us-west-2"
ENV ELASTICSEARCH_HOST "search-pschmitt-iam-access-vx6u2y3upcsmgnu4bcihdf3kge.us-west-2.es.amazonaws.com"
EXPOSE 12201/udp
CMD ["start_logstash.sh"]
