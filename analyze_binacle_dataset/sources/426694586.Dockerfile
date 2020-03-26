FROM openjdk:8-alpine

EXPOSE 8081
WORKDIR /usr/src/app

ADD target/auth-svc-0.0.1-SNAPSHOT.jar auth-svc-0.0.1.jar

CMD ["java", "-jar", "auth-svc-0.0.1.jar"]

