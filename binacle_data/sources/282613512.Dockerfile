FROM openjdk:8-jdk-alpine

ADD target/consumer-test-0.0.1-SNAPSHOT.jar app.jar
ENV JAVA_OPTS=""
ENV DUBBO_REGISTRY_IP=""
ENV DUBBO_REGISTRY_PORT=""
ENTRYPOINT exec java $JAVA_OPTS -jar /app.jar