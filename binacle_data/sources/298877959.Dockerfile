FROM openjdk:11-jdk-slim

ARG ARTIFACT

COPY build/libs/datadog.jar /usr/local/
COPY $ARTIFACT /usr/local/search-api.jar

EXPOSE 8482
ENTRYPOINT exec java $JAVA_OPTS -server -jar /usr/local/search-api.jar
