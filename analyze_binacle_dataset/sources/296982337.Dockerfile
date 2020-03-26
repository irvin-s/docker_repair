FROM openjdk:8-jdk-alpine

LABEL Description="Task client" Version="0.9"

WORKDIR /tmp/

ADD @project.build.finalName@.jar /tmp/
ADD wait-for-it.sh /tmp/

RUN apk add --no-cache bash

EXPOSE 8082
CMD ["./wait-for-it.sh", "--timeout=10", "routing-service:5555", "--", "java -jar", "@project.build.finalName@.jar"]

