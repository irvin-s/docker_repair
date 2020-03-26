FROM docker.elastic.co/logstash/logstash:5.6.4

COPY logstash.conf /usr/share/logstash/pipeline/logstash.conf