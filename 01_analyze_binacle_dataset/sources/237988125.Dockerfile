FROM docker.elastic.co/logstash/logstash:5.1.1
RUN rm -f /usr/share/logstash/pipeline/logstash.conf
ADD ./logstash.yml /usr/share/logstash/pipeline/