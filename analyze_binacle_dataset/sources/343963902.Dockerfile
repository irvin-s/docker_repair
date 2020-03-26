FROM openjdk:8u141-jdk-slim
MAINTAINER jeremydeane.net
EXPOSE 9003
RUN mkdir /app/
COPY target/event-care-router-1.0.4.jar /app/
ENTRYPOINT exec java $JAVA_OPTS -Dactivemq.hostname='event-broker' -jar /app/event-care-router-1.0.4.jar