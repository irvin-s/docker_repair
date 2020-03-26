FROM openjdk:8-jre-alpine

RUN apk add --no-cache curl

ENV JAVA_GC_OPTS="-XX:+UnlockExperimentalVMOptions -XX:+UseCGroupMemoryLimitForHeap -XX:MaxRAMFraction=1 -XX:+UseG1GC" \
    JAVA_OPTS=""

EXPOSE 8080

COPY target/geoip-api.jar /opt/geoip-api.jar

HEALTHCHECK CMD curl -f http://localhost:8080/8.8.8.8

CMD exec java ${JAVA_GC_OPTS} ${JAVA_OPTS} -jar /opt/geoip-api.jar
