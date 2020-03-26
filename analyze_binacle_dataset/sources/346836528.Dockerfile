FROM openjdk:8-jdk-alpine
VOLUME /tmp
ADD cities-service-1.0.jar app.jar
RUN sh -c 'touch /app.jar'
EXPOSE 8080
ENTRYPOINT [ "java", "-jar", "/app.jar" ]
