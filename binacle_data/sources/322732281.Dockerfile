FROM openjdk:8-jdk-alpine
VOLUME /tmp
ARG JAR_FILE
ADD /target/website-acuity-dashboard-1.0-SNAPSHOT.jar app.jar
ENTRYPOINT ["java","-jar","/app.jar"]