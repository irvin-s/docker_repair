FROM openjdk:8u141-jdk-slim
MAINTAINER jeremydeane.net
RUN mkdir /app/
COPY target/event-client-1.0.2.jar /app/
ENTRYPOINT exec java -Dactivemq.hostname='event-broker' -jar /app/event-client-1.0.2.jar $PATIENT