FROM openjdk:11-jre-slim-sid
LABEL maintainer=aakkus

COPY target/docker-compose-initializr-0.0.1-SNAPSHOT.jar lib/docker-compose-initializr.jar

ENTRYPOINT exec java -Djava.security.egd=file:/dev/./urandom $JAVA_OPTS -jar lib/docker-compose-initializr.jar