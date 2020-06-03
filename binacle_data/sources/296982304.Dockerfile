FROM openjdk:8-jdk-alpine

LABEL Description="Config service" Version="0.9"

WORKDIR /tmp/

ADD @project.build.finalName@.jar /tmp/

EXPOSE 8888
ENTRYPOINT ["java", "-jar", "@project.build.finalName@.jar"]

