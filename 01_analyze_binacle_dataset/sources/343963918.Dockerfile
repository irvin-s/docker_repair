FROM openjdk:8u141-jdk-slim
MAINTAINER jeremydeane.net
EXPOSE 9004
RUN mkdir /app/
COPY target/event-cep-router-1.0.4.jar /app/
ENTRYPOINT exec java $JAVA_OPTS -Dactivemq.hostname='event-broker' -jar /app/event-cep-router-1.0.4.jar