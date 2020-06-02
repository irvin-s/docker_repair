FROM openjdk:8-alpine

EXPOSE 8080
WORKDIR /usr/src/app

ADD target/gateway-0.0.1-SNAPSHOT.jar gateway-0.0.1.jar

CMD ["java", "-jar", "gateway-0.0.1.jar"]