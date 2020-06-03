FROM logstash:5.0

COPY logstash.conf /etc/logstash/conf.d/

CMD ["-f", "/etc/logstash/conf.d/logstash.conf"]
