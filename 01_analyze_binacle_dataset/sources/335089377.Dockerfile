FROM confluentinc/cp-kafka:4.0.0-3

RUN pip install --upgrade pip && pip install cqlsh

COPY setup.sh /usr/local/bin/
COPY db-schema.cql /usr/local/share/
COPY cassandra-sink-connector-simple.json /usr/local/share/
COPY cassandra-sink-connector-avro.json /usr/local/share/
COPY config/.cassandra /root/.cassandra

ENTRYPOINT ["/usr/local/bin/setup.sh"]
