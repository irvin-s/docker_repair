FROM openjdk:10.0.1-jdk-slim

MAINTAINER andrelugomes@gmail.com

ADD /build/libs/*.jar app.jar

ENTRYPOINT ["java","-jar","app.jar"]
