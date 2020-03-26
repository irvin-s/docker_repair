FROM openjdk:8u141-jdk-slim
MAINTAINER jeremydeane.net
EXPOSE 9002
RUN mkdir /app/
COPY target/event-audit-router-1.0.4.jar /app/
VOLUME /target/events
ENTRYPOINT exec java $JAVA_OPTS -Dactivemq.hostname='event-broker' -jar /app/event-audit-router-1.0.4.jar