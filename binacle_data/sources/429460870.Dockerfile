FROM openjdk:8-jdk-alpine

COPY target/stateless-async-backend-services-*-microbundle.jar /app.jar
COPY src/main/payara/post-boot.txt /post-boot.txt

ENTRYPOINT ["java", "-jar", "/app.jar", "--postbootcommandfile", "/post-boot.txt"]
