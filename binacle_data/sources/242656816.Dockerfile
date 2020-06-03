FROM logstash:5.2.0

COPY conf/logstash.conf /
RUN chmod 777 /dev/stdout