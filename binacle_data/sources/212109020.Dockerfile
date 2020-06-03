FROM pblittle/docker-logstash:0.13.1

COPY logstash.conf /opt/logstash/conf.d/
COPY config.js /opt/logstash/vendor/kibana/config.js