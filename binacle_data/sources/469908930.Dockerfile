FROM java:8-alpine

MAINTAINER 15398699939@163.com

ADD target/*.jar ./app.jar

EXPOSE 8761

ENTRYPOINT ["java", "-jar", "app.jar"]