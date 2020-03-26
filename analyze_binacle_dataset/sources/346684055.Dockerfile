FROM java:7
MAINTAINER Sebastian Bach <sebastian@scalac.io>

COPY target/deploy/spark-kafka-avro.jar /srv/

#RUN curl -SL http://d3kbcqa49mib13.cloudfront.net/spark-1.4.0-bin-hadoop2.4.tgz \
#    | tar -xzC /srv \
#    && mv /srv/spark-1.4.0-bin-hadoop2.4 /srv/spark
#    && sed -e s/log4j.rootCategory=INFO/log4j.rootCategory=WARN/g /srv/spark/conf/log4j.properties.template > /srv/spark/conf/log4j.properties

COPY spark/spark-1.4.0-bin-hadoop2.4 /srv/spark
RUN sed -e s/log4j.rootCategory=INFO/log4j.rootCategory=WARN/g /srv/spark/conf/log4j.properties.template > /srv/spark/conf/log4j.properties

CMD /srv/spark/bin/spark-submit \
    --class io.scalac.spark.AvroConsumer /srv/spark-kafka-avro.jar \
    --postgres "hostaddr=${POSTGRES_PORT_5432_TCP_ADDR} port=${POSTGRES_PORT_5432_TCP_PORT} dbname=${POSTGRES_DBNAME} user=${POSTGRES_USER}" \
    --broker ${KAFKA_PORT_9092_TCP_ADDR}:${KAFKA_PORT_9092_TCP_PORT} \
    --schema-registry http://${SCHEMA_REGISTRY_PORT_8081_TCP_ADDR}:${SCHEMA_REGISTRY_PORT_8081_TCP_PORT}
