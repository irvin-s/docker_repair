FROM openjdk:10-jdk-slim

MAINTAINER Michel Jung <michel.jung89@gmail.com>

VOLUME /tmp
COPY build/libs/faf-java-server-*.jar app.jar
ENTRYPOINT ["java", "-server", "-Djava.security.egd=file:/dev/./urandom", "-XX:+CompactStrings", "-XX:MaxMetaspaceSize=196m", "-XX:MinHeapFreeRatio=25", "-XX:MaxHeapFreeRatio=40", "-jar", "app.jar"]
