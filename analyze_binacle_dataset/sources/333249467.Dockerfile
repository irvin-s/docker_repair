FROM docker.elastic.co/logstash/logstash-oss:6.2.1

RUN logstash-plugin install logstash-input-beats
RUN logstash-plugin install logstash-output-email
RUN logstash-plugin install logstash-output-slack
