FROM openjdk:8-jdk-alpine
VOLUME /tmp
ARG JAR_FILE
ADD /target/service-bot-control-1.0-SNAPSHOT.jar app.jar
ENTRYPOINT ["java","-jar","/app.jar"]