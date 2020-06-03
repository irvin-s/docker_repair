FROM openjdk:8-jdk-alpine

LABEL Description="Discovery service" Version="0.9"

WORKDIR /tmp/

ADD @project.build.finalName@.jar /tmp/

EXPOSE 8761
ENTRYPOINT ["java", "-jar", "@project.build.finalName@.jar"]

