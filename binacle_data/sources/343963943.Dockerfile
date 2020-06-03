FROM openjdk:8u141-jdk-slim
MAINTAINER jeremydeane.net
EXPOSE 9001
RUN mkdir /app/
COPY target/event-ingestion-router-1.0.4.jar /app/
ENTRYPOINT exec java $JAVA_OPTS -Dactivemq.hostname='event-broker' -jar /app/event-ingestion-router-1.0.4.jar