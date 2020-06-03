FROM 1ambda/kafka-connect:latest
MAINTAINER Andrew Pennebaker <andrew.pennebaker@gmail.com>
COPY build/libs/hello-kafka-connect-all.jar $KAFKA_HOME/connectors/
