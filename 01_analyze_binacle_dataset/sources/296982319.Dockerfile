FROM openjdk:8-jdk-alpine

LABEL Description="OAuth service" Version="0.9"

WORKDIR /tmp/

ADD @project.build.finalName@.jar /tmp/

EXPOSE 9999
ENTRYPOINT ["java", "-jar", "@project.build.finalName@.jar"]

