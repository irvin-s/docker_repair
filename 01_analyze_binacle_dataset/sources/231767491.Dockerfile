FROM openjdk:8-jdk-alpine

ADD target/springboot-docker.jar app.jar

ENTRYPOINT ["java","-jar","/app.jar"]
