FROM openjdk:8u121-jdk-alpine

COPY app/app.jar /usr/local/app.jar

WORKDIR /usr/local/

EXPOSE 8080

CMD ["java", "-jar", "app.jar"]