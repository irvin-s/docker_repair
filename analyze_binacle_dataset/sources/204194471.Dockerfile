# creates an image from executable jar

FROM frolvlad/alpine-oraclejdk8:latest
MAINTAINER <YOUR MAIL>
EXPOSE 8080
ADD spring-boot-app-service-example.jar /app/spring-boot-app-service-example.jar

ENTRYPOINT java -jar /app/spring-boot-app-service-example.jar --server.port=8080
