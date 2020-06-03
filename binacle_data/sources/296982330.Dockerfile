FROM openjdk:8-jdk-alpine

LABEL Description="Zuul routing service" Version="0.9"

WORKDIR /tmp/

ADD @project.build.finalName@.jar /tmp/

EXPOSE 5555
ENTRYPOINT ["java", "-jar", "@project.build.finalName@.jar"]

