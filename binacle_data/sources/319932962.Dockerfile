FROM openjdk:11-jre-slim

LABEL maintainer="support@blueriq.com"

EXPOSE 8080

COPY blueriq-case-engine-tasklist-standalone-*.jar ~/tasklist.jar
COPY blueriq-case-engine-tasklist.yml /config/blueriq-case-engine/

WORKDIR ~

ENTRYPOINT ["java", "-Dspring.config.additional-location=file:///config/blueriq-case-engine/", "-jar", "tasklist.jar", "-Xmx384m" ]