FROM openjdk:8-jdk-alpine

LABEL Description="Task service dev/prod/staging" Version="0.9"

WORKDIR /tmp/

ADD @project.build.finalName@.jar /tmp/
ADD wait-for-it.sh /tmp/

RUN apk add --no-cache bash

EXPOSE 8080
CMD ["./wait-for-it.sh", "--timeout=10", "config-service:8888", "--", "java -jar", "@project.build.finalName@.jar"]

