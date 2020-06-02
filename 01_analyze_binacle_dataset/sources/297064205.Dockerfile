FROM cassandra:3.10

COPY cassandra.yaml /etc/cassandra/
COPY cassandra-prometheus-2.0.0-jar-with-dependencies.jar /usr/share/cassandra/lib/


RUN echo 'JVM_OPTS="$JVM_OPTS -javaagent:/usr/share/cassandra/lib/cassandra-prometheus-2.0.0-jar-with-dependencies.jar=7400"' >> /etc/cassandra/cassandra-env.sh
