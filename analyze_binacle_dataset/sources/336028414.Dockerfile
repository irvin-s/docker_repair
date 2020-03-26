FROM openjdk:8-jdk-alpine
VOLUME /tmp
ADD app.jar app.jar
EXPOSE 8080
ENTRYPOINT ["java","-Xmx2048m","-Djava.security.egd=file:/dev/./urandom","-jar","/app.jar"]