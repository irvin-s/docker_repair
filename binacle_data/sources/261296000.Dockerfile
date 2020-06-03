FROM confluentinc/cp-kafka:3.3.0
COPY kafka.run /etc/confluent/docker/run
RUN ["chmod", "+x", "/etc/confluent/docker/run"]